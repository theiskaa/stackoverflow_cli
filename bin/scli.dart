import 'dart:io';

import 'package:scli/scli.dart';

void main(List<String> arguments) async {
  // It says, that everything is fine here and we can go on.
  // There are 3 exitCode options: [0 - Success | 1 - Warnings | 2 - Errors]
  exitCode = 0;

  await flushThenExit(await CLICommandRunner().run(arguments));
}
