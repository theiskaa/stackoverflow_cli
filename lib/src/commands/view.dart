import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:scli/src/models/answer.dart';
import 'package:scli/src/sc_command_helper.dart';

class View extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  View(this.dio) {
    argParser.addMultiOption(
      'answer',
      abbr: 'a',
      help: """
      View answers by providing question's id.
      You can use it like:
      "scli view --answer <question-id>"
      """,
    );
  }
  @override
  String get description => '''

  View answers/comments of concrete question.
  Able to use just for view answers.

  ''';

  @override
  String get name => 'view';

  @override
  FutureOr<int?> run() async {
    if (argResults?['answer'].isEmpty) {
      log.error(''''
      Error: Please provide a question id to get right answers.

      To learn more just run "scli help view"
      ''');
      exit(ExitCode.noInput.code);
    }

    log.progress('Loading answers');

    var questionID = argResults?['answer'][0];

    await viewAnswers(questionID);
    exit(ExitCode.success.code);
  }

  Future<void> viewAnswers(String qID, [int limit = 0]) async {
    final res = await dio.get(apiGen.answers(qID: qID));
    var answer = Answer.fromJson(res.data);
    log.answer(answer, answer.items?.length);
  }
}
