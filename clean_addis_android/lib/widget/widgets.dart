import 'dart:io';
import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  final Directory workingDir =
      Directory(p.dirname(Platform.script.path)).parent;

  final int status = await _runProcess(
    'dart',
    <String>[
      'test',
      '-p',
      'chrome',
    ],
    workingDirectory: workingDir.path,
  );

  exit(status);
}

Future<Process> _streamOutput(Future<Process> processFuture) async {
  final Process process = await processFuture;
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  return process;
}

Future<int> _runProcess(
  String command,
  List<String> arguments, {
  String? workingDirectory,
}) async {
  final Process process = await _streamOutput(Process.start(
    command,
    arguments,
    workingDirectory: workingDirectory,
  ));
  return process.exitCode;
}
AnchorElement createAnchorElement(String href, String? suggestedName) {
  final AnchorElement element = AnchorElement(href: href);

  if (suggestedName == null) {
    element.download = 'download';
  } else {
    element.download = suggestedName;
  }

  return element;
}

/// Add an element to a container and click it
void addElementToContainerAndClick(Element container, Element element) {
  // Add the element and click it
  // All previous elements will be removed before adding the new one
  container.children.add(element);
  element.click();
}

/// Initializes a DOM container where elements can be injected.
Element ensureInitialized(String id) {
  Element? target = querySelector('#$id');
  if (target == null) {
    final Element targetElement = Element.tag('flt-x-file')..id = id;

    querySelector('body')!.children.add(targetElement);
    target = targetElement;
  }
  return target;
}

/// Determines if the browser is Safari from its vendor string.
/// (This is the same check used in flutter/engine)
bool isSafari() {
  return window.navigator.vendor == 'Apple Computer, Inc.';
}
class SkiaGoldClient {
  /// Creates a [SkiaGoldClient] with the given [workDirectory].
  ///
  /// All other parameters are optional. They may be provided in tests to
  /// override the defaults for [fs], [process], [platform], and [httpClient].
  SkiaGoldClient(
    this.workDirectory, {
    this.fs = const LocalFileSystem(),
    this.process = const LocalProcessManager(),
    this.platform = const LocalPlatform(),
    io.HttpClient? httpClient,
  }) : httpClient = httpClient ?? io.HttpClient();

  /// The file system to use for storing the local clone of the repository.
  ///
  /// This is useful in tests, where a local file system (the default) can be
  /// replaced by a memory file system.
  final FileSystem fs;

  /// A wrapper for the [dart:io.Platform] API.
  ///
  /// This is useful in tests, where the system platform (the default) can be
  /// replaced by a mock platform instance.
  final Platform platform;

  /// A controller for launching sub-processes.
  ///
  /// This is useful in tests, where the real process manager (the default) can
  /// be replaced by a mock process manager that doesn't really create
  /// sub-processes.
  final ProcessManager process;

  /// A client for making Http requests to the Flutter Gold dashboard.
  final io.HttpClient httpClient;

  /// The local [Directory] within the [comparisonRoot] for the current test
  /// context. In this directory, the client will create image and JSON files
  /// for the goldctl tool to use.
  ///
  /// This is informed by the [FlutterGoldenFileComparator] [basedir]. It cannot
  /// be null.
  final Directory workDirectory;

  /// The local [Directory] where the Flutter repository is hosted.
  ///
  /// Uses the [fs] file system.
  Directory get _flutterRoot => fs.directory(platform.environment[_kFlutterRootKey]);

  /// The path to the local [Directory] where the goldctl tool is hosted.
  ///
  /// Uses the [platform] environment in this implementation.
  String get _goldctl => platform.environment[_kGoldctlKey]!;

  /// Prepares the local work space for golden file testing and calls the
  /// goldctl `auth` command.
  ///
  /// This ensures that the goldctl tool is authorized and ready for testing.
  /// Used by the [FlutterPostSubmitFileComparator] and the
  /// [FlutterPreSubmitFileComparator].
  Future<void> auth() async {
    if (await clientIsAuthorized()) {
      return;
    }
    final List<String> authCommand = <String>[
      _goldctl,
      'auth',
      '--work-dir', workDirectory
        .childDirectory('temp')
        .path,
      '--luci',
    ];

    final io.ProcessResult result = await process.run(authCommand);

    if (result.exitCode != 0) {
      final StringBuffer buf = StringBuffer()
        ..writeln('Skia Gold authorization failed.')
        ..writeln('Luci environments authenticate using the file provided '
          'by LUCI_CONTEXT. There may be an error with this file or Gold '
          'authentication.')
        ..writeln('Debug information for Gold:')
        ..writeln('stdout: ${result.stdout}')
        ..writeln('stderr: ${result.stderr}');
      throw Exception(buf.toString());
    }
  }

  /// Signals if this client is initialized for uploading images to the Gold
  /// service.
  ///
  /// Since Flutter framework tests are executed in parallel, and in random
  /// order, this will signal is this instance of the Gold client has been
  /// initialized.
  bool _initialized = false;

  /// Executes the `imgtest init` command in the goldctl tool.
  ///
  /// The `imgtest` command collects and uploads test results to the Skia Gold
  /// backend, the `init` argument initializes the current test. Used by the
  /// [FlutterPostSubmitFileComparator].
  Future<void> imgtestInit() async {
    // This client has already been intialized
    if (_initialized) {
      return;
    }

    final File keys = workDirectory.childFile('keys.json');
    final File failures = workDirectory.childFile('failures.json');

    await keys.writeAsString(_getKeysJSON());
    await failures.create();
    final String commitHash = await _getCurrentCommit();

    final List<String> imgtestInitCommand = <String>[
      _goldctl,
      'imgtest', 'init',
      '--instance', 'flutter',
      '--work-dir', workDirectory
        .childDirectory('temp')
        .path,
      '--commit', commitHash,
      '--keys-file', keys.path,
      '--failure-file', failures.path,
      '--passfail',
    ];

    if (imgtestInitCommand.contains(null)) {
      final StringBuffer buf = StringBuffer()
        ..writeln('A null argument was provided for Skia Gold imgtest init.')
        ..writeln('Please confirm the settings of your golden file test.')
        ..writeln('Arguments provided:');
      imgtestInitCommand.forEach(buf.writeln);
      throw Exception(buf.toString());
    }

    final io.ProcessResult result = await process.run(imgtestInitCommand);

    if (result.exitCode != 0) {
      _initialized = false;
      final StringBuffer buf = StringBuffer()
        ..writeln('Skia Gold imgtest init failed.')
        ..writeln('An error occurred when initializing golden file test with ')
        ..writeln('goldctl.')
        ..writeln()
        ..writeln('Debug information for Gold:')
        ..writeln('stdout: ${result.stdout}')
        ..writeln('stderr: ${result.stderr}');
      throw Exception(buf.toString());
    }
    _initialized = true;
  }

  /// Executes the `imgtest add` command in the goldctl tool.
  ///
  /// The `imgtest` command collects and uploads test results to the Skia Gold
  /// backend, the `add` argument uploads the current image test. A response is
  /// returned from the invocation of this command that indicates a pass or fail
  /// result.
  ///
  /// The [testName] and [goldenFile] parameters reference the current
  /// comparison being evaluated by the [FlutterPostSubmitFileComparator].
  Future<bool> imgtestAdd(String testName, File goldenFile) async {
    final List<String> imgtestCommand = <String>[
      _goldctl,
      'imgtest', 'add',
      '--work-dir', workDirectory
        .childDirectory('temp')
        .path,
      '--test-name', cleanTestName(testName),
      '--png-file', goldenFile.path,
      '--passfail',
      ..._getPixelMatchingArguments(),
    ];

    final io.ProcessResult result = await process.run(imgtestCommand);

    if (result.exitCode != 0) {
      // If an unapproved image has made it to post-submit, throw to close the
      // tree.
      final StringBuffer buf = StringBuffer()
        ..writeln('Skia Gold received an unapproved image in post-submit ')
        ..writeln('testing. Golden file images in flutter/flutter are triaged ')
        ..writeln('in pre-submit during code review for the given PR.')
        ..writeln()
        ..writeln('Visit https://flutter-gold.skia.org/ to view and approve ')
        ..writeln('the image(s), or revert the associated change. For more ')
        ..writeln('information, visit the wiki: ')
        ..writeln('https://github.com/flutter/flutter/wiki/Writing-a-golden-file-test-for-package:flutter')
        ..writeln()
        ..writeln('Debug information for Gold:')
        ..writeln('stdout: ${result.stdout}')
        ..writeln('stderr: ${result.stderr}');
      throw Exception(buf.toString());
    }

    return true;
  }

  /// Signals if this client is initialized for uploading tryjobs to the Gold
  /// service.
  ///
  /// Since Flutter framework tests are executed in parallel, and in random
  /// order, this will signal is this instance of the Gold client has been
  /// initialized for tryjobs.
  bool _tryjobInitialized = false;

  /// Executes the `imgtest init` command in the goldctl tool for tryjobs.
  ///
  /// The `imgtest` command collects and uploads test results to the Skia Gold
  /// backend, the `init` argument initializes the current tryjob. Used by the
  /// [FlutterPreSubmitFileComparator].
  Future<void> tryjobInit() async {
    // This client has already been initialized
    if (_tryjobInitialized) {
      return;
    }

    final File keys = workDirectory.childFile('keys.json');
    final File failures = workDirectory.childFile('failures.json');

    await keys.writeAsString(_getKeysJSON());
    await failures.create();
    final String commitHash = await _getCurrentCommit();

    final List<String> imgtestInitCommand = <String>[
      _goldctl,
      'imgtest', 'init',
      '--instance', 'flutter',
      '--work-dir', workDirectory
        .childDirectory('temp')
        .path,
      '--commit', commitHash,
      '--keys-file', keys.path,
      '--failure-file', failures.path,
      '--passfail',
      '--crs', 'github',
      '--patchset_id', commitHash,
      ...getCIArguments(),
    ];

    if (imgtestInitCommand.contains(null)) {
      final StringBuffer buf = StringBuffer()
        ..writeln('A null argument was provided for Skia Gold tryjob init.')
        ..writeln('Please confirm the settings of your golden file test.')
        ..writeln('Arguments provided:');
      imgtestInitCommand.forEach(buf.writeln);
      throw Exception(buf.toString());
    }

    final io.ProcessResult result = await process.run(imgtestInitCommand);

    if (result.exitCode != 0) {
      _tryjobInitialized = false;
      final StringBuffer buf = StringBuffer()
        ..writeln('Skia Gold tryjobInit failure.')
        ..writeln('An error occurred when initializing golden file tryjob with ')
        ..writeln('goldctl.')
        ..writeln()
        ..writeln('Debug information for Gold:')
        ..writeln('stdout: ${result.stdout}')
        ..writeln('stderr: ${result.stderr}');
      throw Exception(buf.toString());
    }
    _tryjobInitialized = true;
  }

  /// Executes the `imgtest add` command in the goldctl tool for tryjobs.
  ///
  /// The `imgtest` command collects and uploads test results to the Skia Gold
  /// backend, the `add` argument uploads the current image test. A response is
  /// returned from the invocation of this command that indicates a pass or fail
  /// result for the tryjob.
  ///
  /// The [testName] and [goldenFile] parameters reference the current
  /// comparison being evaluated by the [FlutterPreSubmitFileComparator].
  Future<void> tryjobAdd(String testName, File goldenFile) async {
    final List<String> imgtestCommand = <String>[
      _goldctl,
      'imgtest', 'add',
      '--work-dir', workDirectory
        .childDirectory('temp')
        .path,
      '--test-name', cleanTestName(testName),
      '--png-file', goldenFile.path,
      ..._getPixelMatchingArguments(),
    ];

    final io.ProcessResult result = await process.run(imgtestCommand);

    final String/*!*/ resultStdout = result.stdout.toString();
    if (result.exitCode != 0 &&
      !(resultStdout.contains('Untriaged') || resultStdout.contains('negative image'))) {
      final StringBuffer buf = StringBuffer()
        ..writeln('Unexpected Gold tryjobAdd failure.')
        ..writeln('Tryjob execution for golden file test $testName failed for')
        ..writeln('a reason unrelated to pixel comparison.')
        ..writeln()
        ..writeln('Debug information for Gold:')
        ..writeln('stdout: ${result.stdout}')
        ..writeln('stderr: ${result.stderr}')
        ..writeln();
      throw Exception(buf.toString());
    }
  }

  // Constructs arguments for `goldctl` for controlling how pixels are compared.
  //
  // For AOT and CanvasKit exact pixel matching is used. For the HTML renderer
  // on the web a fuzzy matching algorithm is used that allows very small deltas
  // because Chromium cannot exactly reproduce the same golden on all computers.
  // It seems to depend on the hardware/OS/driver combination. However, those
  // differences are very small (typically not noticeable to human eye).
  List<String> _getPixelMatchingArguments() {
    // Only use fuzzy pixel matching in the HTML renderer.
    if (!_isBrowserTest || _isBrowserCanvasKitTest) {
      return const <String>[];
    }

    // The algorithm to be used when matching images. The available options are:
    // - "fuzzy": Allows for customizing the thresholds of pixel differences.
    // - "sobel": Same as "fuzzy" but performs edge detection before performing
    //            a fuzzy match.
    const String algorithm = 'fuzzy';

    // The number of pixels in this image that are allowed to differ from the
    // baseline.
    //
    // The chosen number - 20 - is arbitrary. Even for a small golden file, say
    // 50 x 50, it would be less than 1% of the total number of pixels. This
    // number should not grow too much. If it's growing, it is probably due to a
    // larger issue that needs to be addressed at the infra level.
    const int maxDifferentPixels = 20;

    // The maximum acceptable difference per pixel.
    //
    // Uses the Manhattan distance using the RGBA color components as
    // coordinates. The chosen number - 4 - is arbitrary. It's small enough to
    // both not be noticeable and not trigger test flakes due to sub-pixel
    // golden deltas. This number should not grow too much. If it's growing, it
    // is probably due to a larger issue that needs to be addressed at the infra
    // level.
    const int pixelDeltaThreshold = 4;

    return <String>[
      '--add-test-optional-key', 'image_matching_algorithm:$algorithm',
      '--add-test-optional-key', 'fuzzy_max_different_pixels:$maxDifferentPixels',
      '--add-test-optional-key', 'fuzzy_pixel_delta_threshold:$pixelDeltaThreshold',
    ];
  }

  /// Returns the latest positive digest for the given test known to Flutter
  /// Gold at head.
  Future<String?> getExpectationForTest(String testName) async {
    late String? expectation;
    final String traceID = getTraceID(testName);
    await io.HttpOverrides.runWithHttpOverrides<Future<void>>(() async {
      final Uri requestForExpectations = Uri.parse(
        'https://flutter-gold.skia.org/json/v2/latestpositivedigest/$traceID'
      );
      late String rawResponse;
      try {
        final io.HttpClientRequest request = await httpClient.getUrl(requestForExpectations);
        final io.HttpClientResponse response = await request.close();
        rawResponse = await utf8.decodeStream(response);
        final dynamic jsonResponse = json.decode(rawResponse);
        if (jsonResponse is! Map<String, dynamic>) {
          throw const FormatException('Skia gold expectations do not match expected format.');
        }
        expectation = jsonResponse['digest'] as String?;
      } on FormatException catch (error) {
        // Ideally we'd use something like package:test's printOnError, but best reliabilty
        // in getting logs on CI for now we're just using print.
        // See also: https://github.com/flutter/flutter/issues/91285
        print( // ignore: avoid_print
          'Formatting error detected requesting expectations from Flutter Gold.\n'
          'error: $error\n'
          'url: $requestForExpectations\n'
          'response: $rawResponse'
        );
        rethrow;
      }
    },
      SkiaGoldHttpOverrides(),
    );
    return expectation;
  }

  /// Returns a list of bytes representing the golden image retrieved from the
  /// Flutter Gold dashboard.
  ///
  /// The provided image hash represents an expectation from Flutter Gold.
  Future<List<int>>getImageBytes(String imageHash) async {
    final List<int> imageBytes = <int>[];
    await io.HttpOverrides.runWithHttpOverrides<Future<void>>(() async {
      final Uri requestForImage = Uri.parse(
        'https://flutter-gold.skia.org/img/images/$imageHash.png',
      );
      final io.HttpClientRequest request = await httpClient.getUrl(requestForImage);
      final io.HttpClientResponse response = await request.close();
      await response.forEach((List<int> bytes) => imageBytes.addAll(bytes));
    },
      SkiaGoldHttpOverrides(),
    );
    return imageBytes;
  }

  /// Returns the current commit hash of the Flutter repository.
  Future<String> _getCurrentCommit() async {
    if (!_flutterRoot.existsSync()) {
      throw Exception('Flutter root could not be found: $_flutterRoot\n');
    } else {
      final io.ProcessResult revParse = await process.run(
        <String>['git', 'rev-parse', 'HEAD'],
        workingDirectory: _flutterRoot.path,
      );
      if (revParse.exitCode != 0) {
        throw Exception('Current commit of Flutter can not be found.');
      }
      return (revParse.stdout as String/*!*/).trim();
    }
  }

  /// Returns a JSON String with keys value pairs used to uniquely identify the
  /// configuration that generated the given golden file.
  ///
  /// Currently, the only key value pairs being tracked is the platform the
  /// image was rendered on, and for web tests, the browser the image was
  /// rendered on.
  String _getKeysJSON() {
    final Map<String, dynamic> keys = <String, dynamic>{
      'Platform' : platform.operatingSystem,
      'CI' : 'luci',
    };
    if (_isBrowserTest) {
      keys['Browser'] = _browserKey;
      keys['Platform'] = '${keys['Platform']}-browser';
      if (_isBrowserCanvasKitTest) {
        keys['WebRenderer'] = 'canvaskit';
      }
    }
    return json.encode(keys);
  }

  /// Removes the file extension from the [fileName] to represent the test name
  /// properly.
  String cleanTestName(String fileName) {
    return fileName.split(path.extension(fileName))[0];
  }

  /// Returns a boolean value to prevent the client from re-authorizing itself
  /// for multiple tests.
  Future<bool> clientIsAuthorized() async {
    final File authFile = workDirectory.childFile(fs.path.join(
      'temp',
      'auth_opt.json',
    ))/*!*/;

    if(await authFile.exists()) {
      final String contents = await authFile.readAsString();
      final Map<String, dynamic> decoded = json.decode(contents) as Map<String, dynamic>;
      return !(decoded['GSUtil'] as bool/*!*/);
    }
    return false;
  }

  /// Returns a list of arguments for initializing a tryjob based on the testing
  /// environment.
  List<String> getCIArguments() {
    final String jobId = platform.environment['LOGDOG_STREAM_PREFIX']!.split('/').last;
    final List<String> refs = platform.environment['GOLD_TRYJOB']!.split('/');
    final String pullRequest = refs[refs.length - 2];

    return <String>[
      '--changelist', pullRequest,
      '--cis', 'buildbucket',
      '--jobid', jobId,
    ];
  }

  bool get _isBrowserTest {
    return platform.environment[_kTestBrowserKey] != null;
  }

  bool get _isBrowserCanvasKitTest {
    return _isBrowserTest && platform.environment[_kWebRendererKey] == 'canvaskit';
  }

  String get _browserKey {
    assert(_isBrowserTest);
    return platform.environment[_kTestBrowserKey]!;
  }

  /// Returns a trace id based on the current testing environment to lookup
  /// the latest positive digest on Flutter Gold with a hex-encoded md5 hash of
  /// the image keys.
  String getTraceID(String testName) {
    final Map<String, dynamic> keys = <String, dynamic>{
      if (_isBrowserTest)
        'Browser' : _browserKey,
      if (_isBrowserCanvasKitTest)
        'WebRenderer' : 'canvaskit',
      'CI' : 'luci',
      'Platform' : platform.operatingSystem,
      'name' : testName,
      'source_type' : 'flutter',
    };
    final String jsonTrace = json.encode(keys);
    final String md5Sum = md5.convert(utf8.encode(jsonTrace)).toString();
    return md5Sum;
  }
}

/// Used to make HttpRequests during testing.
class SkiaGoldHttpOverrides extends io.HttpOverrides { }
void main() {
  group('text contrast guideline', () {
    testWidgets('black text on white background - Text Widget - direct style',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          const Text(
            'this is a test',
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('white text on black background - Text Widget - direct style',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.black,
            child: const Text(
              'this is a test',
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    const Color surface = Color(0xFFF0F0F0);

    /// Shades of blue with contrast ratio of 2.9, 4.4, 4.5 from [surface].
    const Color blue29 = Color(0xFF7E7EFB);
    const Color blue44 = Color(0xFF5757FF);
    const Color blue45 = Color(0xFF5252FF);
    const List<TextStyle> textStylesMeetingGuideline = <TextStyle>[
      TextStyle(color: blue44, backgroundColor: surface, fontSize: 18),
      TextStyle(color: blue44, backgroundColor: surface, fontSize: 14, fontWeight: FontWeight.bold),
      TextStyle(color: blue45, backgroundColor: surface),
    ];
    const List<TextStyle> textStylesDoesNotMeetingGuideline = <TextStyle>[
      TextStyle(color: blue44, backgroundColor: surface),
      TextStyle(color: blue29, backgroundColor: surface, fontSize: 18),
    ];

    Widget appWithTextWidget(TextStyle style) => _boilerplate(
      Text('this is text', style: style.copyWith(height: 30.0)),
    );

    for (final TextStyle style in textStylesMeetingGuideline) {
      testWidgets('text with style $style', (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(appWithTextWidget(style));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
    }

    for (final TextStyle style in textStylesDoesNotMeetingGuideline) {
      testWidgets('text with $style', (WidgetTester tester) async {
        final SemanticsHandle handle = tester.ensureSemantics();
        await tester.pumpWidget(appWithTextWidget(style));
        await expectLater(tester, doesNotMeetGuideline(textContrastGuideline));
        handle.dispose();
      });
    }

    testWidgets('black text on white background - Text Widget - direct style',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          const Text(
            'this is a test',
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('white text on black background - Text Widget - direct style',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.black,
            child: const Text(
              'this is a test',
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('Material text field - amber on amber',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.amberAccent,
            child: TextField(
              style: const TextStyle(color: Colors.amber),
              controller: TextEditingController(text: 'this is a test'),
            ),
          ),
        ),
      );
      await expectLater(tester, doesNotMeetGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('Material text field - default style',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          SizedBox(
            width: 100,
            child: TextField(
              controller: TextEditingController(text: 'this is a test'),
            ),
          ),
        ),
      );
      await tester.idle();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('yellow text on yellow background fails with correct message',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          Container(
            width: 200.0,
            height: 200.0,
            color: Colors.yellow,
            child: const Text(
              'this is a test',
              style: TextStyle(fontSize: 14.0, color: Colors.yellowAccent),
            ),
          ),
        ),
      );
      final Evaluation result = await textContrastGuideline.evaluate(tester);
      expect(result.passed, false);
      expect(
        result.reason,
        'SemanticsNode#4(Rect.fromLTRB(300.0, 200.0, 500.0, 400.0), '
        'label: "this is a test", textDirection: ltr):\n'
        'Expected contrast ratio of at least 4.5 but found 1.17 for a font '
        'size of 14.0.\n'
        'The computed colors was:\n'
        'light - Color(0xfffafafa), dark - Color(0xffffeb3b)\n'
         'See also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      );
      handle.dispose();
    });

    testWidgets('label without corresponding text is skipped',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          Semantics(
            label: 'This is not text',
            container: true,
            child: const SizedBox(
              width: 200.0,
              height: 200.0,
              child: Placeholder(),
            ),
          ),
        ),
      );

      final Evaluation result = await textContrastGuideline.evaluate(tester);
      expect(result.passed, true);
      handle.dispose();
    });

    testWidgets('offscreen text is skipped', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          Stack(
            children: <Widget>[
              Positioned(
                left: -300.0,
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.yellow,
                  child: const Text(
                    'this is a test',
                    style: TextStyle(fontSize: 14.0, color: Colors.yellowAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      final Evaluation result = await textContrastGuideline.evaluate(tester);
      expect(result.passed, true);
      handle.dispose();
    });

    testWidgets('Disabled button is excluded from text contrast guideline',
        (WidgetTester tester) async {
      // Regression test https://github.com/flutter/flutter/issues/94428
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _boilerplate(
          ElevatedButton(
            onPressed: null,
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.yellow,
              child: const Text(
                'this is a test',
                style: TextStyle(fontSize: 14.0, color: Colors.yellowAccent),
              ),
            ),
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
  });

  group('custom minimum contrast guideline', () {
    Widget iconWidget({
      IconData icon = Icons.search,
      required Color color,
      required Color background,
    }) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        color: background,
        child: Icon(icon, color: color),
      );
    }

    Widget textWidget({
      String text = 'Text',
      required Color color,
      required Color background,
    }) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        color: background,
        child: Text(text, style: TextStyle(color: color)),
      );
    }

    Widget rowWidget(List<Widget> widgets) => _boilerplate(Row(children: widgets));

    final Finder findIcons = find.byWidgetPredicate((Widget widget) => widget is Icon);
    final Finder findTexts = find.byWidgetPredicate((Widget widget) => widget is Text);
    final Finder findIconsAndTexts = find.byWidgetPredicate((Widget widget) => widget is Icon || widget is Text);

    testWidgets('Black icons on white background', (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.black, background: Colors.white),
        iconWidget(color: Colors.black, background: Colors.white),
      ]));

      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('Black icons on black background', (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.black, background: Colors.black),
        iconWidget(color: Colors.black, background: Colors.black),
      ]));

      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('White icons on black background ("dark mode")',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.white, background: Colors.black),
        iconWidget(color: Colors.white, background: Colors.black),
      ]));

      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('Using different icons', (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.black, background: Colors.white, icon: Icons.more_horiz),
        iconWidget(color: Colors.black, background: Colors.white, icon: Icons.description),
        iconWidget(color: Colors.black, background: Colors.white, icon: Icons.image),
        iconWidget(color: Colors.black, background: Colors.white, icon: Icons.beach_access),
      ]));

      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('One invalid instance fails entire test',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.black, background: Colors.white),
        iconWidget(color: Colors.black, background: Colors.black),
      ]));

      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('White on different colors, passing',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.white, background: Colors.red[800]!, icon: Icons.more_horiz),
        iconWidget(color: Colors.white, background: Colors.green[800]!, icon: Icons.description),
        iconWidget(color: Colors.white, background: Colors.blue[800]!, icon: Icons.image),
        iconWidget(color: Colors.white, background: Colors.purple[800]!, icon: Icons.beach_access),
      ]));

      await expectLater(tester,
          meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)));
    });

    testWidgets('White on different colors, failing',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.white, background: Colors.red[200]!, icon: Icons.more_horiz),
        iconWidget(color: Colors.white, background: Colors.green[400]!, icon: Icons.description),
        iconWidget(color: Colors.white, background: Colors.blue[600]!, icon: Icons.image),
        iconWidget(color: Colors.white, background: Colors.purple[800]!, icon: Icons.beach_access),
      ]));

      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('Absence of icons, passing', (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[]));

      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('Absence of icons, passing - 2nd test',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        textWidget(color: Colors.black, background: Colors.white),
        textWidget(color: Colors.black, background: Colors.black),
      ]));

      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
    });

    testWidgets('Guideline ignores widgets of other types',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.black, background: Colors.white),
        iconWidget(color: Colors.black, background: Colors.white),
        textWidget(color: Colors.black, background: Colors.white),
        textWidget(color: Colors.black, background: Colors.black),
      ]));

      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findTexts)),
      );
      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findIconsAndTexts)),
      );
    });

    testWidgets('Custom minimum ratio - Icons', (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.blue, background: Colors.white),
        iconWidget(color: Colors.black, background: Colors.white),
      ]));

      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findIcons, minimumRatio: 3.0)),
      );
    });

    testWidgets('Custom minimum ratio - Texts', (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        textWidget(color: Colors.blue, background: Colors.white),
        textWidget(color: Colors.black, background: Colors.white),
      ]));

      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findTexts)),
      );
      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findTexts, minimumRatio: 3.0)),
      );
    });

    testWidgets(
        'Custom minimum ratio - Different standards for icons and texts',
        (WidgetTester tester) async {
      await tester.pumpWidget(rowWidget(<Widget>[
        iconWidget(color: Colors.blue, background: Colors.white),
        iconWidget(color: Colors.black, background: Colors.white),
        textWidget(color: Colors.blue, background: Colors.white),
        textWidget(color: Colors.black, background: Colors.white),
      ]));

      await expectLater(
        tester,
        doesNotMeetGuideline(CustomMinimumContrastGuideline(finder: findIcons)),
      );
      await expectLater(
        tester,
        meetsGuideline(CustomMinimumContrastGuideline(finder: findTexts, minimumRatio: 3.0)),
      );
    });
  });

  group('tap target size guideline', () {
    testWidgets('Tappable box at 48 by 48', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(
        SizedBox(
          width: 48.0,
          height: 48.0,
          child: GestureDetector(onTap: () {}),
        ),
      ));
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });

    testWidgets('Tappable box at 47 by 48', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(
        SizedBox(
          width: 47.0,
          height: 48.0,
          child: GestureDetector(onTap: () {}),
        ),
      ));
      await expectLater(
        tester,
        doesNotMeetGuideline(androidTapTargetGuideline),
      );
      handle.dispose();
    });

    testWidgets('Tappable box at 48 by 47', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(
        SizedBox(
          width: 48.0,
          height: 47.0,
          child: GestureDetector(onTap: () {}),
        ),
      ));
      await expectLater(
        tester,
        doesNotMeetGuideline(androidTapTargetGuideline),
      );
      handle.dispose();
    });

    testWidgets('Tappable box at 48 by 48 shrunk by transform',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(
        Transform.scale(
          scale: 0.5, // should have new height of 24 by 24.
          child: SizedBox(
            width: 48.0,
            height: 48.0,
            child: GestureDetector(onTap: () {}),
          ),
        ),
      ));
      await expectLater(
        tester,
        doesNotMeetGuideline(androidTapTargetGuideline),
      );
      handle.dispose();
    });

    testWidgets('Too small tap target fails with the correct message',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(
        SizedBox(
          width: 48.0,
          height: 47.0,
          child: GestureDetector(onTap: () {}),
        ),
      ));
      final Evaluation result = await androidTapTargetGuideline.evaluate(tester);
      expect(result.passed, false);
      expect(
        result.reason,
        'SemanticsNode#4(Rect.fromLTRB(376.0, 276.5, 424.0, 323.5), '
        'actions: [tap]): expected tap '
        'target size of at least Size(48.0, 48.0), '
        'but found Size(48.0, 47.0)\n'
        'See also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      );
      handle.dispose();
    });

    testWidgets('Box that overlaps edge of window is skipped',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      final Widget smallBox = SizedBox(
        width: 48.0,
        height: 47.0,
        child: GestureDetector(onTap: () {}),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: <Widget>[
              Positioned(
                left: 0.0,
                top: -1.0,
                child: smallBox,
              ),
            ],
          ),
        ),
      );

      final Evaluation overlappingTopResult = await androidTapTargetGuideline.evaluate(tester);
      expect(overlappingTopResult.passed, true);

      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: <Widget>[
              Positioned(
                left: -1.0,
                top: 0.0,
                child: smallBox,
              ),
            ],
          ),
        ),
      );

      final Evaluation overlappingLeftResult = await androidTapTargetGuideline.evaluate(tester);
      expect(overlappingLeftResult.passed, true);

      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: <Widget>[
              Positioned(
                bottom: -1.0,
                child: smallBox,
              ),
            ],
          ),
        ),
      );

      final Evaluation overlappingBottomResult = await androidTapTargetGuideline.evaluate(tester);
      expect(overlappingBottomResult.passed, true);

      await tester.pumpWidget(
        MaterialApp(
          home: Stack(
            children: <Widget>[
              Positioned(
                right: -1.0,
                child: smallBox,
              ),
            ],
          ),
        ),
      );

      final Evaluation overlappingRightResult = await androidTapTargetGuideline.evaluate(tester);
      expect(overlappingRightResult.passed, true);
      handle.dispose();
    });

    testWidgets('Does not fail on mergedIntoParent child',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(MergeSemantics(
        child: Semantics(
          container: true,
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: Semantics(
              container: true,
              child: GestureDetector(
                onTap: () {},
                child: const SizedBox(width: 4.0, height: 4.0),
              ),
            ),
          ),
        ),
      )));

      final Evaluation overlappingRightResult = await androidTapTargetGuideline.evaluate(tester);
      expect(overlappingRightResult.passed, true);
      handle.dispose();
    });

    testWidgets('Does not fail on links', (WidgetTester tester) async {
      Widget textWithLink() {
        return Builder(
          builder: (BuildContext context) {
            return RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  const TextSpan(text: 'See examples at '),
                  TextSpan(
                    text: 'flutter repo',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            );
          },
        );
      }

      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(textWithLink()));

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
  });

  group('Labeled tappable node guideline', () {
    testWidgets('Passes when node is labeled', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(Semantics(
        container: true,
        onTap: () {},
        label: 'test',
        child: const SizedBox(width: 10.0, height: 10.0),
      )));
      final Evaluation result = await labeledTapTargetGuideline.evaluate(tester);
      expect(result.passed, true);
      handle.dispose();
    });
    testWidgets('Fails if long-press has no label',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(Semantics(
        container: true,
        onLongPress: () {},
        label: '',
        child: const SizedBox(width: 10.0, height: 10.0),
      )));
      final Evaluation result = await labeledTapTargetGuideline.evaluate(tester);
      expect(result.passed, false);
      handle.dispose();
    });

    testWidgets('Fails if tap has no label', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(Semantics(
        container: true,
        onTap: () {},
        label: '',
        child: const SizedBox(width: 10.0, height: 10.0),
      )));
      final Evaluation result = await labeledTapTargetGuideline.evaluate(tester);
      expect(result.passed, false);
      handle.dispose();
    });

    testWidgets('Passes if tap is merged into labeled node',
        (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(_boilerplate(Semantics(
        container: true,
        onLongPress: () {},
        label: '',
        child: Semantics(
          label: 'test',
          child: const SizedBox(width: 10.0, height: 10.0),
        ),
      )));
      final Evaluation result = await labeledTapTargetGuideline.evaluate(tester);
      expect(result.passed, true);
      handle.dispose();
    });
  });

  testWidgets('regression test for material widget',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFFBBC04),
            elevation: 0,
          ),
          onPressed: () {},
          child: const Text('Button', style: TextStyle(color: Colors.black)),
        ),
      ),
    ));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}

Widget _boilerplate(Widget child) =>
  MaterialApp(home: Scaffold(body: Center(child: child)));
  void main() {
  group('getSemanticsData', () {
    testWidgets('throws when there are no semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text('hello'),
          ),
        ),
      );

      expect(() => tester.getSemantics(find.text('hello')), throwsStateError);
    }, semanticsEnabled: false);

    testWidgets('throws when there are multiple results from the finder', (WidgetTester tester) async {
      final SemanticsHandle semanticsHandle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: const <Widget>[
                Text('hello'),
                Text('hello'),
              ],
            ),
          ),
        ),
      );

      expect(() => tester.getSemantics(find.text('hello')), throwsStateError);
      semanticsHandle.dispose();
    });

    testWidgets('Returns the correct SemanticsData', (WidgetTester tester) async {
      final SemanticsHandle semanticsHandle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlinedButton(
                onPressed: () { },
                child: const Text('hello'),
            ),
          ),
        ),
      );

      final SemanticsNode node = tester.getSemantics(find.text('hello'));
      final SemanticsData semantics = node.getSemanticsData();
      expect(semantics.label, 'hello');
      expect(semantics.hasAction(SemanticsAction.tap), true);
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
      semanticsHandle.dispose();
    });

    testWidgets('Can enable semantics for tests via semanticsEnabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlinedButton(
                onPressed: () { },
                child: const Text('hello'),
            ),
          ),
        ),
      );

      final SemanticsNode node = tester.getSemantics(find.text('hello'));
      final SemanticsData semantics = node.getSemanticsData();
      expect(semantics.label, 'hello');
      expect(semantics.hasAction(SemanticsAction.tap), true);
      expect(semantics.hasFlag(SemanticsFlag.isButton), true);
    });

    testWidgets('Returns merged SemanticsData', (WidgetTester tester) async {
      final SemanticsHandle semanticsHandle = tester.ensureSemantics();
      const Key key = Key('test');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Semantics(
              label: 'A',
              child: Semantics(
                label: 'B',
                child: Semantics(
                  key: key,
                  label: 'C',
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
      );

      final SemanticsNode node = tester.getSemantics(find.byKey(key));
      final SemanticsData semantics = node.getSemanticsData();
      expect(semantics.label, 'A\nB\nC');
      semanticsHandle.dispose();
    });

    testWidgets('Does not return partial semantics', (WidgetTester tester) async {
      final SemanticsHandle semanticsHandle = tester.ensureSemantics();
      final Key key = UniqueKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MergeSemantics(
              child: Semantics(
                container: true,
                label: 'A',
                child: Semantics(
                  container: true,
                  key: key,
                  label: 'B',
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
      );

      final SemanticsNode node = tester.getSemantics(find.byKey(key));
      final SemanticsData semantics = node.getSemanticsData();
      expect(semantics.label, 'A\nB');
      semanticsHandle.dispose();
    });
  });

  testWidgets(
    'WidgetTester.drag must break the offset into multiple parallel components if '
    'the drag goes outside the touch slop values',
    (WidgetTester tester) async {
      // This test checks to make sure that the total drag will be correctly split into
      // pieces such that the first (and potentially second) moveBy function call(s) in
      // controller.drag() will never have a component greater than the touch
      // slop in that component's respective axis.
      const List<TestDragData> offsetResults = <TestDragData>[
        TestDragData(
          Offset(10.0, 10.0),
          Offset(-150.0, 200.0),
          <Offset>[
            Offset(-7.5, 10.0),
            Offset(-2.5, 3.333333333333333),
            Offset(-140.0, 186.66666666666666),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(150, -200),
          <Offset>[
            Offset(7.5, -10),
            Offset(2.5, -3.333333333333333),
            Offset(140.0, -186.66666666666666),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(-200, 150),
          <Offset>[
            Offset(-10, 7.5),
            Offset(-3.333333333333333, 2.5),
            Offset(-186.66666666666666, 140.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(200.0, -150.0),
          <Offset>[
            Offset(10, -7.5),
            Offset(3.333333333333333, -2.5),
            Offset(186.66666666666666, -140.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(-150.0, -200.0),
          <Offset>[
            Offset(-7.5, -10.0),
            Offset(-2.5, -3.333333333333333),
            Offset(-140.0, -186.66666666666666),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(8.0, 3.0),
          <Offset>[
            Offset(8.0, 3.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(3.0, 8.0),
          <Offset>[
            Offset(3.0, 8.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(20.0, 5.0),
          <Offset>[
            Offset(10.0, 2.5),
            Offset(10.0, 2.5),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(5.0, 20.0),
          <Offset>[
            Offset(2.5, 10.0),
            Offset(2.5, 10.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(20.0, 15.0),
          <Offset>[
            Offset(10.0, 7.5),
            Offset(3.333333333333333, 2.5),
            Offset(6.666666666666668, 5.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(15.0, 20.0),
          <Offset>[
            Offset(7.5, 10.0),
            Offset(2.5, 3.333333333333333),
            Offset(5.0, 6.666666666666668),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(20.0, 20.0),
          <Offset>[
            Offset(10.0, 10.0),
            Offset(10.0, 10.0),
          ],
        ),
        TestDragData(
          Offset(10.0, 10.0),
          Offset(0.0, 5.0),
          <Offset>[
            Offset(0.0, 5.0),
          ],
        ),

        //// Varying touch slops
        TestDragData(
          Offset(12.0, 5.0),
          Offset(0.0, 5.0),
          <Offset>[
            Offset(0.0, 5.0),
          ],
        ),
        TestDragData(
          Offset(12.0, 5.0),
          Offset(20.0, 5.0),
          <Offset>[
            Offset(12.0, 3.0),
            Offset(8.0, 2.0),
          ],
        ),
        TestDragData(
          Offset(12.0, 5.0),
          Offset(5.0, 20.0),
          <Offset>[
            Offset(1.25, 5.0),
            Offset(3.75, 15.0),
          ],
        ),
        TestDragData(
          Offset(5.0, 12.0),
          Offset(5.0, 20.0),
          <Offset>[
            Offset(3.0, 12.0),
            Offset(2.0, 8.0),
          ],
        ),
        TestDragData(
          Offset(5.0, 12.0),
          Offset(20.0, 5.0),
          <Offset>[
            Offset(5.0, 1.25),
            Offset(15.0, 3.75),
          ],
        ),
        TestDragData(
          Offset(18.0, 18.0),
          Offset(0.0, 150.0),
          <Offset>[
            Offset(0.0, 18.0),
            Offset(0.0, 132.0),
          ],
        ),
        TestDragData(
          Offset(18.0, 18.0),
          Offset(0.0, -150.0),
          <Offset>[
            Offset(0.0, -18.0),
            Offset(0.0, -132.0),
          ],
        ),
        TestDragData(
          Offset(18.0, 18.0),
          Offset(-150.0, 0.0),
          <Offset>[
            Offset(-18.0, 0.0),
            Offset(-132.0, 0.0),
          ],
        ),
        TestDragData(
          Offset.zero,
          Offset(-150.0, 0.0),
          <Offset>[
            Offset(-150.0, 0.0),
          ],
        ),
        TestDragData(
          Offset(18.0, 18.0),
          Offset(-32.0, 0.0),
          <Offset>[
            Offset(-18.0, 0.0),
            Offset(-14.0, 0.0),
          ],
        ),
      ];

      final List<Offset> dragOffsets = <Offset>[];

      await tester.pumpWidget(
        Listener(
          onPointerMove: (PointerMoveEvent event) {
            dragOffsets.add(event.delta);
          },
          child: const Text('test', textDirection: TextDirection.ltr),
        ),
      );

      for (int resultIndex = 0; resultIndex < offsetResults.length; resultIndex += 1) {
        final TestDragData testResult = offsetResults[resultIndex];
        await tester.drag(
          find.text('test'),
          testResult.dragDistance,
          touchSlopX: testResult.slop.dx,
          touchSlopY: testResult.slop.dy,
        );
        expect(
          testResult.expectedOffsets.length,
          dragOffsets.length,
          reason:
            'There is a difference in the number of expected and actual split offsets for the drag with:\n'
            'Touch Slop: ${testResult.slop}\n'
            'Delta:      ${testResult.dragDistance}\n',
        );
        for (int valueIndex = 0; valueIndex < offsetResults[resultIndex].expectedOffsets.length; valueIndex += 1) {
          expect(
            testResult.expectedOffsets[valueIndex],
            offsetMoreOrLessEquals(dragOffsets[valueIndex]),
            reason:
              'There is a difference in the expected and actual value of the '
              '${valueIndex == 2 ? 'first' : valueIndex == 3 ? 'second' : 'third'}'
              ' split offset for the drag with:\n'
              'Touch slop: ${testResult.slop}\n'
              'Delta:      ${testResult.dragDistance}\n'
          );
        }
        dragOffsets.clear();
      }
    },
  );

  testWidgets(
    'WidgetTester.tap must respect buttons',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.buttons}'),
            onPointerMove: (PointerMoveEvent event) => logs.add('move ${event.buttons}'),
            onPointerUp: (PointerUpEvent event) => logs.add('up ${event.buttons}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.tap(find.text('test'), buttons: kSecondaryMouseButton);

      const String b = '$kSecondaryMouseButton';
      for(int i = 0; i < logs.length; i++) {
        if (i == 0) {
          expect(logs[i], 'down $b');
        } else if (i != logs.length - 1) {
          expect(logs[i], 'move $b');
        } else {
          expect(logs[i], 'up 0');
        }
      }
    },
  );

  testWidgets(
    'WidgetTester.press must respect buttons',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.buttons}'),
            onPointerMove: (PointerMoveEvent event) => logs.add('move ${event.buttons}'),
            onPointerUp: (PointerUpEvent event) => logs.add('up ${event.buttons}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.press(find.text('test'), buttons: kSecondaryMouseButton);

      const String b = '$kSecondaryMouseButton';
      expect(logs, equals(<String>['down $b']));
    },
  );

  testWidgets(
    'WidgetTester.longPress must respect buttons',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.buttons}'),
            onPointerMove: (PointerMoveEvent event) => logs.add('move ${event.buttons}'),
            onPointerUp: (PointerUpEvent event) => logs.add('up ${event.buttons}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.longPress(find.text('test'), buttons: kSecondaryMouseButton);
      await tester.pumpAndSettle();

      const String b = '$kSecondaryMouseButton';
      for(int i = 0; i < logs.length; i++) {
        if (i == 0) {
          expect(logs[i], 'down $b');
        } else if (i != logs.length - 1) {
          expect(logs[i], 'move $b');
        } else {
          expect(logs[i], 'up 0');
        }
      }
    },
  );

  testWidgets(
    'WidgetTester.drag must respect buttons',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.buttons}'),
            onPointerMove: (PointerMoveEvent event) => logs.add('move ${event.buttons}'),
            onPointerUp: (PointerUpEvent event) => logs.add('up ${event.buttons}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.drag(find.text('test'), const Offset(-150.0, 200.0), buttons: kSecondaryMouseButton);

      const String b = '$kSecondaryMouseButton';
      for(int i = 0; i < logs.length; i++) {
        if (i == 0) {
          expect(logs[i], 'down $b');
        } else if (i != logs.length - 1) {
          expect(logs[i], 'move $b');
        } else {
          expect(logs[i], 'up 0');
        }
      }
    },
  );

  testWidgets(
    'WidgetTester.fling must respect buttons',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.buttons}'),
            onPointerMove: (PointerMoveEvent event) => logs.add('move ${event.buttons}'),
            onPointerUp: (PointerUpEvent event) => logs.add('up ${event.buttons}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.fling(find.text('test'), const Offset(-10.0, 0.0), 1000.0, buttons: kSecondaryMouseButton);
      await tester.pumpAndSettle();

      const String b = '$kSecondaryMouseButton';
      for(int i = 0; i < logs.length; i++) {
        if (i == 0) {
          expect(logs[i], 'down $b');
        } else if (i != logs.length - 1) {
          expect(logs[i], 'move $b');
        } else {
          expect(logs[i], 'up 0');
        }
      }
    },
  );

  testWidgets(
    'WidgetTester.fling produces strictly monotonically increasing timestamps, '
    'when given a large velocity',
    (WidgetTester tester) async {
      // Velocity trackers may misbehave if the `PointerMoveEvent`s' have the
      // same timestamp. This is more likely to happen when the velocity tracker
      // has a small sample size.
      final List<Duration> logs = <Duration>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerMove: (PointerMoveEvent event) => logs.add(event.timeStamp),
            child: const Text('test'),
          ),
        ),
      );

      await tester.fling(find.text('test'), const Offset(0.0, -50.0), 10000.0);
      await tester.pumpAndSettle();

      for (int i = 0; i + 1 < logs.length; i += 1) {
        expect(logs[i + 1],  greaterThan(logs[i]));
      }
  });

  testWidgets(
    'WidgetTester.timedDrag must respect buttons',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.buttons}'),
            onPointerMove: (PointerMoveEvent event) => logs.add('move ${event.buttons}'),
            onPointerUp: (PointerUpEvent event) => logs.add('up ${event.buttons}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.timedDrag(
        find.text('test'),
        const Offset(-200.0, 0.0),
        const Duration(seconds: 1),
        buttons: kSecondaryMouseButton,
      );
      await tester.pumpAndSettle();

      const String b = '$kSecondaryMouseButton';
      for(int i = 0; i < logs.length; i++) {
        if (i == 0) {
          expect(logs[i], 'down $b');
        } else if (i != logs.length - 1) {
          expect(logs[i], 'move $b');
        } else {
          expect(logs[i], 'up 0');
        }
      }
    },
  );

  testWidgets(
    'WidgetTester.timedDrag uses correct pointer',
    (WidgetTester tester) async {
      final List<String> logs = <String>[];

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => logs.add('down ${event.pointer}'),
            child: const Text('test'),
          ),
        ),
      );

      await tester.timedDrag(
        find.text('test'),
        const Offset(-200.0, 0.0),
        const Duration(seconds: 1),
        buttons: kSecondaryMouseButton,
      );
      await tester.pumpAndSettle();

      await tester.timedDrag(
        find.text('test'),
        const Offset(200.0, 0.0),
        const Duration(seconds: 1),
        buttons: kSecondaryMouseButton,
      );
      await tester.pumpAndSettle();

      expect(logs.length, 2);
      expect(logs[0], isNotNull);
      expect(logs[1], isNotNull);
      expect(logs[1] != logs[0], isTrue);
    },
  );

  testWidgets(
    'ensureVisible: scrolls to make widget visible',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) => ListTile(title: Text('Item $i')),
            ),
          ),
        ),
      );

      // Make sure widget isn't on screen
      expect(find.text('Item 15'), findsNothing);

      await tester.ensureVisible(find.text('Item 15', skipOffstage: false));
      await tester.pumpAndSettle();

      expect(find.text('Item 15'), findsOneWidget);
    },
  );

  group('scrollUntilVisible: scrolls to make unbuilt widget visible', () {
    testWidgets(
      'Vertical',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: 50,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) => ListTile(title: Text('Item $i')),
              ),
            ),
          ),
        );

        // Make sure widget isn't built yet.
        expect(find.text('Item 45', skipOffstage: false), findsNothing);

        await tester.scrollUntilVisible(
          find.text('Item 45', skipOffstage: false),
          100,
        );
        await tester.pumpAndSettle();

        // Now the widget is on screen.
        expect(find.text('Item 45'), findsOneWidget);
      },
    );

    testWidgets(
      'Horizontal',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: 50,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // ListTile does not support horizontal list
                itemBuilder: (BuildContext context, int i) => Text('Item $i'),
              ),
            ),
          ),
        );

        // Make sure widget isn't built yet.
        expect(find.text('Item 45', skipOffstage: false), findsNothing);

        await tester.scrollUntilVisible(
          find.text('Item 45', skipOffstage: false),
          100,
        );
        await tester.pumpAndSettle();

        // Now the widget is on screen.
        expect(find.text('Item 45'), findsOneWidget);
      },
    );

    testWidgets(
      'Fail',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: 50,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) => ListTile(title: Text('Item $i')),
              ),
            ),
          ),
        );

        try {
          await tester.scrollUntilVisible(
            find.text('Item 55', skipOffstage: false),
            100,
          );
        } on StateError catch (e) {
          expect(e.message, 'No element');
        }
      },
    );

    testWidgets('Drag Until Visible', (WidgetTester tester) async {
      // when there are two implicit [Scrollable], `scrollUntilVisible` is hard
      // to use.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: 200, child: ListView.builder(
                  key: const Key('listView-a'),
                  itemCount: 50,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) => ListTile(title: Text('Item a-$i')),
                )),
                const Divider(thickness: 5),
                Expanded(child: ListView.builder(
                  key: const Key('listView-b'),
                  itemCount: 50,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) => ListTile(title: Text('Item b-$i')),
                )),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(Scrollable), findsNWidgets(2));

      // Make sure widget isn't built yet.
      expect(find.text('Item b-45', skipOffstage: false), findsNothing);

      await tester.dragUntilVisible(
        find.text('Item b-45', skipOffstage: false),
        find.byKey(const ValueKey<String>('listView-b')),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();

      // Now the widget is on screen.
      expect(find.text('Item b-45'), findsOneWidget);
    });
  });
}