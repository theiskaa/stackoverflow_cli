import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:io/io.dart';
import 'package:scli/src/version.dart';
import 'commands/get_questions.dart';
import 'commands/sc_command.dart';

class CLICommandRunner extends CommandRunner<int?> with SCLIcommandHelper {
  CLICommandRunner()
      : super(
          'scli',
          'StackOverflow under your fingers | Made with Dart lang and Hearth 💙',
        ) {
    argParser.addFlag(
      'version',
      negatable: false,
      abbr: 'v',
      help: 'Print the current version.',
    );

    addCommand(Get());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      return await runCommand(parse(args)) ?? ExitCode.success.code;
    } on FormatException catch (e) {
      log
        ..error(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      log
        ..error(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      log.info('StackOverflow CLI - $cliVersion');
      return ExitCode.success.code;
    }
    return super.runCommand(topLevelResults);
  }
}
