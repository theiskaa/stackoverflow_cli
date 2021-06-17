import 'package:scli/src/logger.dart';
import 'package:scli/src/models/answer.dart';
import 'package:scli/src/models/question.dart';
import 'package:test/test.dart';

const jsonQuestion = {
  'items': [
    {
      'tags': ['javascript', 'node.js', 'flutter', 'cors'],
      'owner': {
        'reputation': 2413,
        'user_id': 9663497,
        'user_type': 'registered',
        'profile_image':
            'https://www.gravatar.com/avatar/a2146a2188db75aa6c8d552e7804ea30?s=128&d=identicon&r=PG&f=1',
        'display_name': 'Vincenzo',
        'link': 'https://stackoverflow.com/users/9663497/vincenzo'
      },
      'is_answered': false,
      'view_count': 22,
      'answer_count': 1,
      'score': 0,
      'last_activity_date': 1623526190,
      'creation_date': 1623517727,
      'last_edit_date': 1623526190,
      'question_id': 67951186,
      'content_license': 'CC BY-SA 4.0',
      'link':
          'https://stackoverflow.com/questions/67951186/cant-allow-cors-in-my-node-server-node-js-server-flutter-web-app',
      'title':
          'Can&#39;t allow cors in my node server Node.js server / Flutter web app'
    }
  ],
  'has_more': true,
  'quota_max': 10000,
  'quota_remaining': 9984
};

const jsonAnswer = {
  'items': [
    {
      'owner': {
        'reputation': 507,
        'user_id': 14247462,
        'user_type': 'registered',
        'profile_image': 'https://i.stack.imgur.com/FvNOn.png?s=128&g=1',
        'display_name': 'theiskaa',
        'link': 'https://stackoverflow.com/users/14247462/theiskaa'
      },
      'is_accepted': true,
      'score': 1,
      'last_activity_date': 1623182663,
      'creation_date': 1623182663,
      'answer_id': 67893903,
      'question_id': 67893709,
      'content_license': 'CC BY-SA 4.0'
    }
  ],
  'has_more': false,
  'quota_max': 10000,
  'quota_remaining': 9947
};

void main() {
  late Logger logger;
  late Question question;
  late Answer answer;

  setUpAll(() {
    logger = Logger();
    question = Question.fromJson(jsonQuestion);
    answer = Answer.fromJson(jsonAnswer);
  });

  group('[Logger]', () {
    test('info', () => logger.info('info'));
    test('delayed', () => logger.delayed('delayed'));
    test('progress', () => logger.progress('progress'));
    test('error', () => logger.error('error'));
    test('alert', () => logger.alert('alert'));
    test('warn', () => logger.warn('warn'));
    test('success', () => logger.success('success'));
    test('question', () => logger.questions(question, 1));
    test('question', () => logger.answers(answer, 1));
    test('line', () => logger.line());
    test('empty', () => logger.empty());
  });
}
