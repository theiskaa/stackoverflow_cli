import 'package:io/io.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:scli/scli.dart';

void main() {
  late DioAdapter dioAdapter;
  late Api api;
  late CLICommandRunner commandRunner;

  var questionBodyForDefault = {
    'items': List.generate(
      5,
      (i) => {
        'tags': ['reactjs', 'select', 'drop-down-menu'],
        'owner': {
          'reputation': 1,
          'user_id': 16214864,
          'user_type': 'registered',
          'profile_image':
              'https://www.gravatar.com/avatar/9950ea0a2e7a5e23b53a41e986a53c4a?s=128&d=identicon&r=PG&f=1',
          'display_name': 'XinxLax',
          'link': 'https://stackoverflow.com/users/16214864/xinxlax'
        },
        'is_answered': false,
        'view_count': 6,
        'answer_count': 1,
        'score': 0,
        'last_activity_date': 1623774566,
        'creation_date': 1623773260,
        'question_id': 67989824,
        'content_license': 'CC BY-SA 4.0',
        'link':
            'https://stackoverflow.com/questions/67989824/how-do-i-retrieve-the-selected-value-from-a-dropdown-menu-in-reactjs',
        'title':
            'How do I retrieve the selected value from a dropdown menu in ReactJS'
      },
    ),
    'has_more': true,
    'quota_max': 10000,
    'quota_remaining': 9997
  };

  const questionBodyForLimit = {
    'items': [
      {
        'tags': ['reactjs', 'select', 'drop-down-menu'],
        'owner': {
          'reputation': 1,
          'user_id': 16214864,
          'user_type': 'registered',
          'profile_image':
              'https://www.gravatar.com/avatar/9950ea0a2e7a5e23b53a41e986a53c4a?s=128&d=identicon&r=PG&f=1',
          'display_name': 'XinxLax',
          'link': 'https://stackoverflow.com/users/16214864/xinxlax'
        },
        'is_answered': false,
        'view_count': 6,
        'answer_count': 1,
        'score': 0,
        'last_activity_date': 1623774566,
        'creation_date': 1623773260,
        'question_id': 67989824,
        'content_license': 'CC BY-SA 4.0',
        'link':
            'https://stackoverflow.com/questions/67989824/how-do-i-retrieve-the-selected-value-from-a-dropdown-menu-in-reactjs',
        'title':
            'How do I retrieve the selected value from a dropdown menu in ReactJS'
      }
    ],
    'has_more': true,
    'quota_max': 10000,
    'quota_remaining': 9997
  };

  var questionBodyForAll = {
    'items': List.generate(
      100,
      (i) => {
        'tags': ['reactjs', 'select', 'drop-down-menu'],
        'owner': {
          'reputation': 1,
          'user_id': 16214864,
          'user_type': 'registered',
          'profile_image':
              'https://www.gravatar.com/avatar/9950ea0a2e7a5e23b53a41e986a53c4a?s=128&d=identicon&r=PG&f=1',
          'display_name': 'XinxLax',
          'link': 'https://stackoverflow.com/users/16214864/xinxlax'
        },
        'is_answered': false,
        'view_count': 6,
        'answer_count': 1,
        'score': 0,
        'last_activity_date': 1623774566,
        'creation_date': 1623773260,
        'question_id': 67989824,
        'content_license': 'CC BY-SA 4.0',
        'link':
            'https://stackoverflow.com/questions/67989824/how-do-i-retrieve-the-selected-value-from-a-dropdown-menu-in-reactjs',
        'title':
            'How do I retrieve the selected value from a dropdown menu in ReactJS'
      },
    ),
    'has_more': true,
    'quota_max': 10000,
    'quota_remaining': 9997
  };

  const question = {
    'items': [
      {
        'tags': ['flutter'],
        'owner': {
          'reputation': 796,
          'user_id': 8843528,
          'user_type': 'registered',
          'profile_image':
              'https://lh4.googleusercontent.com/-tsgB41k1IYg/AAAAAAAAAAI/AAAAAAAAAC8/y9awt3dCDmo/photo.jpg?sz=128',
          'display_name': 'SuuSoJeat',
          'link': 'https://stackoverflow.com/users/8843528/suusojeat'
        },
        'is_answered': true,
        'view_count': 27087,
        'answer_count': 4,
        'score': 69,
        'last_activity_date': 1623775197,
        'creation_date': 1552657817,
        'question_id': 55184105,
        'content_license': 'CC BY-SA 4.0',
        'link':
            'https://stackoverflow.com/questions/55184105/does-flutter-automatically-display-cupertino-ui-in-ios-and-material-in-android-w',
        'title':
            'Does Flutter automatically display Cupertino UI in iOS and Material in Android with a single codebase?'
      }
    ],
    'has_more': true,
    'quota_max': 10000,
    'quota_remaining': 9996
  };

  setUp(() {
    dioAdapter = DioAdapter();

    api = Api();
    commandRunner = CLICommandRunner();
    commandRunner.dio.httpClientAdapter = dioAdapter;
  });

  group('[Get]', () {
    test('test as default', () async {
      dioAdapter.onGet(
        api.get(tags: null),
        (request) => request.reply(200, questionBodyForDefault),
      );

      var result = await commandRunner.run(['get']);
      expect(result, equals(ExitCode.success.code));
    });

    test('test --all', () async {
      dioAdapter.onGet(
        api.get(limit: 100, tags: null),
        (request) => request.reply(200, questionBodyForAll),
      );

      var result = await commandRunner.run(['get', '-a']);
      expect(result, equals(ExitCode.success.code));
    });

    test('test --id', () async {
      dioAdapter.onGet(
        api.get(id: 8843528, tags: null),
        (request) => request.reply(200, question),
      );

      var result = await commandRunner.run(['get', '--id', '8843528']);
      expect(result, equals(ExitCode.success.code));
    });

    test('test --limit', () async {
      dioAdapter.onGet(
        api.get(limit: 1, tags: null),
        (request) => request.reply(200, questionBodyForLimit),
      );

      var result = await commandRunner.run(['get', '--limit', '1']);
      expect(result, equals(ExitCode.success.code));
    });

    test('test --tag', () async {
      dioAdapter.onGet(
        api.get(tags: const ['flutter']),
        (request) => request.reply(200, questionBodyForDefault),
      );

      var result = await commandRunner.run(['get', '--tag', 'flutter']);
      expect(result, equals(ExitCode.success.code));
    });

    test('test --limit and --tag together', () async {
      dioAdapter.onGet(
        api.get(limit: 1, tags: ['flutter']),
        (request) => request.reply(200, question),
      );

      var result = await commandRunner.run(['get', '-t', 'flutter', '-l', '1']);
      expect(result, equals(ExitCode.success.code));
    });
  });
}
