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
      ..addMultiOption(
        'tag',
        abbr: 't',
        help: "Get questions by providing language/tool 's tags",
      )
      ..addOption(
        'limit',
        abbr: 'l',
        help: 'Get questions by providing custom limit',
      )
      ..addOption(
        'id',
        help: 'Get concrete question by id',
      );
  }

  @override
  String get description => '''
  Get newest questions. As default would get exectly 5 question from general questions timeline.
  To get more or less use "limit" option, or to get questions about concrete language/tool use "tag" option, or to get question by id use "id" option.
  Run "scli help get" to learn more about limits.
  ''';

  @override
  String get name => 'get';

  @override
  FutureOr<int?> run() async {
    log.progress('Loading questions');

    var limit;
    var id;
    List<String>? tags;

    // Detect right question limit and id.
    if (argResults?['id'] != null) {
      limit = 1;
      id = int.parse(argResults?['id']);
    } else {
      print(argResults?['tag']);

      // Set right question tags.
      if (argResults?['tag'].isNotEmpty) {
        tags = argResults?['tag'];
      }

      limit = argResults?['all']
          ? 100
          : (argResults?['limit'] != null)
              ? int.parse(argResults?['limit'])
              : 5;
    }

    await getQuestions(limit, id, tags);
    ExitCode.success.code;
  }

  Future<void> getQuestions([
    int? limit = 5,
    int? id,
    List<String>? tags,
  ]) async {
    final res = await dio.get(api.get(limit: limit, id: id, tags: tags));
    var question = Question.fromJson(res.data);
    log.question(question, limit);
  }
}
