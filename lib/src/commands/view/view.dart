import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';

import 'package:scli/src/commands/view/view-answer.dart';
import 'package:scli/src/models/answer.dart';
import 'package:scli/src/sc_command_helper.dart';

class View extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  View(this.dio) {
    addSubcommand(ViewAnswer(dio));
  }

  @override
  String get description => 'View answers/comments of concrete question';

  @override
  String get name => 'view';

  @override
  FutureOr<int?> run() async {
    log.progress('Loading answers');

    var questionID = argResults?.command?.arguments[0];

    // await viewAnswers(questionID);
    // exit(ExitCode.success.code);
  }

  Future<void> viewAnswers(String? qID, [int limit = 0]) async {
    final res = await dio.get(apiGen.answers(qID: qID!));
    var answer = Answer.fromJson(res.data);
    log.answer(answer, answer.items?.length);
  }
}
