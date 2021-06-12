import 'package:dio/dio.dart';
import 'package:scli/scli.dart';
import 'package:scli/src/logger.dart';
import 'package:scli/src/sc_command_helper.dart';
import 'package:test/test.dart';

// Just a test class which extended from [SCLIcommandHelper]
// to test inital values. Just like mocked class.
class TestCommand extends SCLIcommandHelper {}

void main() {
  late SCLIcommandHelper sclIcommandHelper;

  setUpAll(() => sclIcommandHelper = TestCommand());

  test('[SCLIcommandHelper] - should contain inital properties', () {
    expect(sclIcommandHelper.api.runtimeType, Api().runtimeType);
    expect(sclIcommandHelper.dio.runtimeType, Dio().runtimeType);
    expect(sclIcommandHelper.log.runtimeType, Logger().runtimeType);
  });
}
