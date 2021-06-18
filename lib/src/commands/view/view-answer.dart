import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:scli/src/models/answer.dart';
import 'package:scli/src/sc_command_helper.dart';

class ViewAnswers extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  ViewAnswers(this.dio) {
    argParser.addOption('limit',
        abbr: 'l', help: 'Provide a limit for getted answers');
  }

  @override
  String get description => 'View answers of concrete question.';

  @override
  String get name => 'answers';

  @override
  FutureOr<int?> run() async {
    if (argResults!.arguments.isEmpty) {
      log.error(''''
      Error: Please provide a question id to get right answers.
      ''');
      exit(ExitCode.noInput.code);
    }

    log.progress('Loading answers');
    var questionID = argResults!.arguments[0];
    var limit =
        (argResults?['limit'] != null) ? int.parse(argResults?['limit']) : 0;

    await viewAnswers(questionID, limit);
    exit(ExitCode.success.code);
  }

  Future<void> viewAnswers(String qID, [int limit = 0]) async {
    final res = await dio.get(apiGen.getAnswers(qID: qID, limit: limit));
    var answer = Answer.fromJson(res.data);
    log.answers(answer, answer.items?.length);
  }
}
