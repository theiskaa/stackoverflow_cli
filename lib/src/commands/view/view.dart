import 'package:dio/dio.dart';
import 'package:args/command_runner.dart';

import 'package:scli/src/commands/view/view-answer.dart';
import 'package:scli/src/commands/view/view-comment.dart';
import 'package:scli/src/sc_command_helper.dart';

class View extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  View(this.dio) {
    addSubcommand(ViewAnswers(dio));
    addSubcommand(ViewComments(dio));
  }

  @override
  String get description => 'View answers/comments of concrete question';

  @override
  String get name => 'view';
}
