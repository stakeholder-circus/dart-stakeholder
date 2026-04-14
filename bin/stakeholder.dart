import 'dart:io';

import 'package:dart_stakeholder/src/runtime.dart';

void main(List<String> args) {
  final result = StakeholderRuntime().run(args);
  if (result.stdoutText.isNotEmpty) {
    stdout.write(result.stdoutText);
  }
  if (result.stderrText.isNotEmpty) {
    stderr.write(result.stderrText);
  }
  exit(result.exitCode);
}
