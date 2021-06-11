import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:io/io.dart';
import 'package:scli/src/commands/sc_command.dart';
import 'package:scli/src/models/question.dart';

class Get extends Command<int?> with SCLIcommandHelper {
  @override
  String get description => '''
  Get newest questions, as default it gets 10 new questions.
  To customize it, just add count of how many question you want like: [scli get 15]
  ''';

  @override
  String get name => 'get';

  @override
  FutureOr<int?> run() async {
    log.progress('Loading newest questions');
    await getQuestions();
    ExitCode.success.code;
  }

  Future<void> getQuestions() async {
    final res = await dio.get(api.get());
    var question = Question.fromJson(res.data);
    log.question(question, 10);
  }
}
