import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:scli/src/models/comment.dart';
import 'package:scli/src/sc_command_helper.dart';

class ViewComments extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  ViewComments(this.dio);

  @override
  String get description => 'View comments of concrete question.';

  @override
  String get name => 'comments';

  @override
  FutureOr<int?> run() async {
    if (argResults!.arguments.isEmpty) {
      log.error(''''
      Error: Please provide a question id to get right comments.
      ''');
      exit(ExitCode.noInput.code);
    }

    log.progress('Loading comments');
    var questionID = argResults!.arguments[0];

    await viewComments(questionID);
    exit(ExitCode.success.code);
  }

  Future<void> viewComments(String qID, [int limit = 0]) async {
    final res = await dio.get(apiGen.getComments(qID: qID));
    var comment = Comment.fromJson(res.data);
    log.comments(comment, comment.items?.length);
  }
}
