import 'dart:io';

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that won't complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future flushThenExit(int status) async {
  await Future.wait<void>([stdout.close(), stderr.close()]);
  exit(status);
}
