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