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