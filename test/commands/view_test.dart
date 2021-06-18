import 'package:io/io.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:scli/scli.dart';

const jsonAnswersList = {
  'items': [
    {
      'owner': {
        'reputation': 517,
        'user_id': 14247462,
        'user_type': 'registered',
        'profile_image': 'https://i.stack.imgur.com/FvNOn.png?s=128&g=1',
        'display_name': 'theiskaa',
        'link': 'https://stackoverflow.com/users/14247462/theiskaa'
      },
      'is_accepted': false,
      'score': 4,
      'last_activity_date': 1619866097,
      'last_edit_date': 1619866097,
      'creation_date': 1615622668,
      'answer_id': 66611321,
      'question_id': 66542199,
      'content_license': 'CC BY-SA 4.0'
    },
    {
      'owner': {
        'reputation': 166,
        'user_id': 15493154,
        'user_type': 'registered',
        'profile_image':
            'https://www.gravatar.com/avatar/c8770bbff6c2baed2b797ddfcfa5bda8?s=128&d=identicon&r=PG',
        'display_name': 'Yaqub',
        'link': 'https://stackoverflow.com/users/15493154/yaqub'
      },
      'is_accepted': true,
      'score': 14,
      'last_activity_date': 1617241388,
      'last_edit_date': 1617241388,
      'creation_date': 1617241085,
      'answer_id': 66897368,
      'question_id': 66542199,
      'content_license': 'CC BY-SA 4.0'
    },
    {
      'owner': {
        'reputation': 339,
        'user_id': 6727586,
        'user_type': 'registered',
        'profile_image':
            'https://graph.facebook.com/878171828982796/picture?type=large',
        'display_name': 'Ali Hussein Al-Issa',
        'link': 'https://stackoverflow.com/users/6727586/ali-hussein-al-issa'
      },
      'is_accepted': false,
      'score': 4,
      'last_activity_date': 1615621199,
      'creation_date': 1615621199,
      'answer_id': 66611138,
      'question_id': 66542199,
      'content_license': 'CC BY-SA 4.0'
    }
  ],
  'has_more': false,
  'quota_max': 10000,
  'quota_remaining': 9938
};

void main() {
  late DioAdapter dioAdapter;
  late ApiGen api;
  late CLICommandRunner commandRunner;

  setUp(() {
    dioAdapter = DioAdapter();

    api = ApiGen();
    commandRunner = CLICommandRunner();
    commandRunner.dio.httpClientAdapter = dioAdapter;
  });

  group('[View]', () {
    group('(Answers)', () {
      test('test default view ', () async {
        dioAdapter.onGet(
          api.getAnswers(qID: '66542197'),
          (request) => request.reply(200, jsonAnswersList),
        );

        var result = await commandRunner.run(['view', 'answers', '66542197']);
        expect(result, equals(ExitCode.success.code));
      });

      test('test view with limit ', () async {
        dioAdapter.onGet(
          api.getAnswers(qID: '66542197', limit: 1),
          (request) => request.reply(200, jsonAnswersList),
        );

        var result = await commandRunner.run(
          ['view', 'answers', '66542197', '-l', '1'],
        );
        expect(result, equals(ExitCode.success.code));
      });
    });

    group('(Comments)', () {
      test('test comments view ', () async {
        dioAdapter.onGet(
          api.getComments(qID: '66542197'),
          (request) => request.reply(200, jsonAnswersList),
        );

        var result = await commandRunner.run(['view', 'comments', '66542197']);
        expect(result, equals(ExitCode.success.code));
      });
    });
  });
}
