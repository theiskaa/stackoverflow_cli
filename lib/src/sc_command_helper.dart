import 'package:dio/dio.dart';
import 'package:scli/src/api_generator.dart';
import 'package:scli/src/logger.dart';

/// Abstract class to make custom commands with already implemented variables.
abstract class SCLIcommandHelper {
  Dio dio = Dio();

  /// Api class. Which can create api url in accordance with the fields.
  ApiGen apiGen = ApiGen();

  /// CLI logger, to print console messages.
  /// And also questions, answers, or comments.
  Logger log = Logger();
}
