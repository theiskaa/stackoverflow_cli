import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:io/io.dart';
import 'package:scli/src/sc_command_helper.dart';
import 'package:scli/src/models/question.dart';

class Search extends Command<int?> with SCLIcommandHelper {
  @override
  Dio dio;

  Search(this.dio) {
    argParser
      ..addMultiOption(
        'tag',
        abbr: 't',
        help: "Search questions by providing language/tool 's tags",
      )
      ..addOption(
        'limit',
        abbr: 'l',
        help: 'Search questions by providing custom limit',
      );
  }
  @override
  String get description => '''
  Search question. Require to provide a search text.
  ''';

  @override
  String get name => 'search';

  @override
  FutureOr<int?> run() async {
    if (argResults!.arguments.isEmpty) {
      log.error("Error: Couldn't found a search text");
      exit(ExitCode.noInput.code);
    }

    var searchText = argResults?.arguments[0];
    var limit;
    List<String>? tags;

    if (argResults?['tag'].isNotEmpty) {
      tags = argResults?['tag'];
    }
    limit =
        (argResults?['limit'] != null) ? int.parse(argResults?['limit']) : 0;

    log.progress('Searching for: "$searchText"');
    await searchQuestions(searchText, limit, tags);
  }

  Future<void> searchQuestions(
    String? inTitle, [
    int? limit,
    List<String>? tags,
  ]) async {
    final res = await dio.get(api.search(
      inTitle: inTitle!,
      limit: limit,
      tags: tags,
    ));
    var question = Question.fromJson(res.data);
    log.question(question, question.items?.length);
  }
}
