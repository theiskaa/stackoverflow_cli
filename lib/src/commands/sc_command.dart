import 'package:dio/dio.dart';
import 'package:scli/src/api.dart';
import 'package:scli/src/logger.dart';

/// Abstract class for make custom commands with already implemented things.
abstract class SCLIcommandHelper {
  Dio dio = Dio();

  /// Api class where every request setting and running.
  Api api = Api();

  /// CLI logger, it just has functions which can print messages.
  Logger log = Logger();
}
