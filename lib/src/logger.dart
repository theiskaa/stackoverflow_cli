import 'dart:async';

import 'dart:io';

import 'package:io/ansi.dart';
import 'package:scli/src/models/question.dart';

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

  void question(Question question, [var questionLength = 5]) {
    var rightTermine = questionLength > 1 ? 'questions' : 'question';
    var vl = '${white.wrap('|')}';
    empty();
    stdout
        .write('${lightMagenta.wrap('Found $questionLength $rightTermine:')}');
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

  void line() {
    empty();
    stdout.write(
      '${black.wrap('------------------------------------------------------------------')}',
    );
    empty();
  }

  void empty() => stdout.write(
        '''
    
      ''',
      );
}
