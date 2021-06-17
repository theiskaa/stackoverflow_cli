import 'dart:async';

import 'dart:io';

import 'package:io/ansi.dart';
import 'package:scli/src/models/comment.dart';
import 'package:scli/src/models/question.dart';

import 'models/answer.dart';

class Logger {
  static const List<String> _appleProgressAnimation = [
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏'
  ];

  static const List<String> _progressAnimation = [
    '~',
    '-~',
    '~',
    '-~',
    '~',
    '-~',
    '~',
    '-'
  ];

  final _queue = <String?>[];

  final _stopwatch = Stopwatch();
  Timer? _timer;
  int _index = 0;

  /// Writes info message to stdout.
  void info(String? message) => stdout.writeln(message);

  /// Writes delayed message to stdout.
  void delayed(String? message) => _queue.add(message);

  /// Writes progress message to stdout.
  void Function([String? update]) progress(
    String message, {
    bool dotsAnimation = false,
  }) {
    _stopwatch
      ..reset()
      ..start();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 80), (t) {
      _index++;
      final char = dotsAnimation
          ? _progressAnimation[_index % _progressAnimation.length]
          : _appleProgressAnimation[_index % _progressAnimation.length];
      stdout.write(
        '''${lightGreen.wrap('\b${'\b' * (message.length + 4)}$char')} $message...''',
      );
    });
    return ([String? update]) {
      _stopwatch.stop();
      final time =
          (_stopwatch.elapsed.inMilliseconds / 1000.0).toStringAsFixed(1);
      stdout.write(
        '''${lightGreen.wrap('\b${'\b' * (message.length + 4)}✓')} ${update ?? message} (${time}ms)\n''',
      );
      _timer?.cancel();
    };
  }

  /// Writes error message to stdout.
  void error(String? message) => stdout.writeln(lightRed.wrap(message));

  /// Writes alert message to stdout.
  void alert(String? message) {
    stdout.writeln(lightCyan.wrap(styleBold.wrap(message)));
  }

  /// Writes warning message to stdout.
  void warn(String? message) {
    stdout.writeln(yellow.wrap(styleBold.wrap('[WARN] $message')));
  }

  /// Writes success message to stdout.
  void success(String? message) => stdout.writeln(lightGreen.wrap(message));

  void questions(Question question, [var questionLength = 5]) {
    var rightTermine = questionLength > 1 ? 'questions' : 'question';
    var vl = '${white.wrap('|')}';
    empty();
    stdout.write(styleBold.wrap(
      '${lightMagenta.wrap('Found $questionLength $rightTermine:')}',
    ));
    for (var i = 0; i < questionLength; i++) {
      var id = '${lightYellow.wrap('@${question.items![i].questionId}')}';
      var title = '${lightGreen.wrap('"${question.items![i].title}"')}';
      var link = '${lightBlue.wrap('${question.items![i].link}')}';
      var tags = '${lightCyan.wrap('${question.items?[i].tags}')}';
      var isAnswered = question.items![i].isAnswered!
          ? lightGreen.wrap('Answered')
          : lightRed.wrap('Not answered');
      var answers = '${lightMagenta.wrap('${question.items![i].answerCount}')}';
      var score = '${lightMagenta.wrap('${question.items![i].score}')}';
      line();
      stdout.write(
        '''
      $id - $title
      Tags: $tags

      --> $isAnswered $vl Answers: $answers $vl Score: $score
      ${white.wrap('See more')}: $link
        ''',
      );
    }
  }

  void answers(Answer answer, [int? answersLength = 1]) {
    var rightTermine = answersLength! > 1 ? 'answers' : 'answer';
    var vl = styleBlink.wrap('${white.wrap('|')}');

    empty();
    stdout.write(styleBold.wrap(
      '${lightMagenta.wrap('Found $answersLength $rightTermine:')}',
    ));
    for (var i = 0; i < answersLength; i++) {
      var id = '${lightYellow.wrap('#${answer.items?[i].questionId}')}';
      var owner = '${yellow.wrap('"${answer.items?[i].owner?.displayName}"')}'
          .replaceAll('"', '');
      var score = '${lightMagenta.wrap('${answer.items?[i].score}')}';
      var link =
          '${lightBlue.wrap('https://stackoverflow.com/a/${answer.items?[i].questionId}/${answer.items?[i].answerId}')}';
      var isAccepted = answer.items![i].isAccepted!
          ? lightGreen.wrap('${styleBold.wrap('Accepted')}')
          : lightRed.wrap('${styleBold.wrap('Not accepted')}');
      line();
      stdout.write(
        '''
      $id $vl Answerer: - $owner
      --> $isAccepted $vl Score: $score
      ${white.wrap('See more')}: $link
        ''',
      );
    }
  }

  void comments(Comment comment, [int? commentsLength = 1]) {
    var rightTermine = commentsLength! > 1 ? 'comments' : 'comment';
    var vl = styleBlink.wrap('${white.wrap('|')}');

    empty();
    stdout.write(styleBold.wrap(
      '${lightMagenta.wrap('Found $commentsLength $rightTermine:')}',
    ));
    for (var i = 0; i < commentsLength; i++) {
      var id = '${lightYellow.wrap('#${comment.items?[i].commentId}')}';
      var owner = '${yellow.wrap('"${comment.items?[i].owner?.displayName}"')}'
          .replaceAll('"', '');
      var score = '${lightMagenta.wrap('${comment.items?[i].score}')}';
      var link =
          '${lightBlue.wrap('https://stackoverflow.com/questions/${comment.items?[i].postId}')}';
      line();
      stdout.write(
        '''
      $id $vl Score: $score $vl Commenter: - $owner
      ${white.wrap('See more')}: $link
        ''',
      );
    }
  }

  void line() {
    empty();
    stdout.write(
      styleBold.wrap(black.wrap(
        '------------------------------------------------------------------',
      )),
    );
    empty();
  }

  void empty() => stdout.write(
        '''
    
      ''',
      );
}
