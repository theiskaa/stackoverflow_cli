import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:io/io.dart';
import 'package:scli/src/commands/sc_command.dart';
import 'package:scli/src/models/question.dart';

class Get extends Command<int?> with SCLIcommandHelper {
  Get() {
    argParser
      ..addFlag(
        'all',
        abbr: 'a',
        help: 'Get all(100) questions',
        defaultsTo: false,
      )
      ..addOption(
        'limit',
        abbr: 'l',
        help: 'Get questions by providing custom limit',
      );
  }

  @override
  String get description => '''
  Get newest questions. As default would get exectly 5 question.
  To get more or less use limits.
  Run "scli help get" to learn more about limits.
  ''';

  @override
  String get name => 'get';

  @override
  FutureOr<int?> run() async {
    log.progress('Loading newest questions');

    // Detect right question limit.
    var limit = argResults?['all']
        ? 100
        : (argResults?['limit'] != null)
            ? int.parse(argResults?['limit'])
            : 5;

    await getQuestions(limit);
    ExitCode.success.code;
  }

  Future<void> getQuestions([int? limit = 5]) async {
    final res = await dio.get(api.get(limit: limit));
    var question = Question.fromJson(res.data);
    log.question(question, limit);
  }
}
