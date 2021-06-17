// ignore_for_file: no_adjacent_strings_in_list
import 'dart:async';

import 'package:io/io.dart';
import 'package:test/test.dart';

import 'package:scli/scli.dart';

const expectedPrintLogs = [
  'StackOverflow under your fingers | Made with Dart lang and Hearth 💙\n'
      '\n'
      'Usage: scli <command> [arguments]\n'
      '\n'
      'Global options:\n'
      '-h, --help       Print this usage information.\n'
      '-v, --version    Print the current version.\n'
      '\n'
      'Available commands:\n'
      '  get        Get newest questions. As default would get exectly 5 question from general questions timeline.\n'
      '  search     Search question. Require to provide a search text.\n'
      '  view     View answers/comments of concrete question\n'
      '\n'
      'Run "scli help <command>" for more information about a command.'
];

void main() {
  group('CLICommandRunner', () {
    late List<String> printLogs;
    late CLICommandRunner commandRunner;

    void Function() overridePrint(void Function() fn) {
      return () {
        final spec = ZoneSpecification(print: (_, __, ___, String msg) {
          printLogs.add(msg);
        });
        return Zone.current.fork(specification: spec).run<void>(fn);
      };
    }

    setUp(() {
      printLogs = [];
      commandRunner = CLICommandRunner();
    });

    test('can be instantiated without an explicit logger instance', () {
      final commandRunner = CLICommandRunner();
      expect(commandRunner, isNotNull);
    });

    group('run', () {
      test('handles no command', overridePrint(() async {
        final result = await commandRunner.run([]);
        expect(printLogs, equals(expectedPrintLogs));
        expect(result, ExitCode.success.code);
      }));

      // TODO: Complete tests by adding FormatException handler test.

      test('handles UsageException', overridePrint(() async {
        var result = await commandRunner.run(['any']);
        expect(printLogs, equals([]));
        expect(result, equals(ExitCode.usage.code));
      }));

      group('--help', () {
        test('outputs usage', overridePrint(() async {
          final result = await commandRunner.run(['--help']);
          expect(printLogs, equals(expectedPrintLogs));
          expect(result, equals(ExitCode.success.code));

          printLogs.clear();

          final resultAbbr = await commandRunner.run(['-h']);
          expect(printLogs, equals(expectedPrintLogs));
          expect(resultAbbr, equals(ExitCode.success.code));
        }));
      });

      group('--version', () {
        test('outputs current version', () async {
          final result = await commandRunner.run(['--version']);
          expect(result, equals(ExitCode.success.code));

          printLogs.clear();

          final resultAbbr = await commandRunner.run(['-v']);
          expect(resultAbbr, equals(ExitCode.success.code));
        });
      });
    });
  });
}
