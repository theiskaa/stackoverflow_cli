import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:scli/src/models/answer.dart';
import 'package:scli/src/sc_command_helper.dart';

class ViewAnswer extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  ViewAnswer(this.dio);

  @override
  String get description => 'View answers of concrete question.';

  @override
  String get name => 'answer';

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

    await viewAnswers(questionID);
    exit(ExitCode.success.code);
  }

  Future<void> viewAnswers(String qID, [int limit = 0]) async {
    final res = await dio.get(apiGen.answers(qID: qID));
    var answer = Answer.fromJson(res.data);
    log.answer(answer, answer.items?.length);
  }
}
