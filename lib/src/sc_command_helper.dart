import 'package:dio/dio.dart';
import 'package:scli/src/api.dart';
import 'package:scli/src/logger.dart';

/// Abstract class to make custom commands with already implemented variables.
abstract class SCLIcommandHelper {
  Dio dio = Dio();

  /// Api class. Which can create api url in accordance with the fields.
  Api api = Api();

  /// CLI logger, to print console messages.
  /// And also questions, answers, or comments.
  Logger log = Logger();
}
