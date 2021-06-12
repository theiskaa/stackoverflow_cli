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

  /// Flushes internal message queue.
  void flush([Function(String?)? print]) {
    final writeln = print ?? info;
    for (final message in _queue) {
      writeln(message);
    }
    _queue.clear();
  }

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

  /// Prompts user and returns response.
  String prompt(String? message) {
    stdout.write('$message');
    return stdin.readLineSync() ?? '';
  }

  void question(Question question, [var questionLength = 5]) {
    var rightTermine = questionLength > 1 ? 'questions' : 'question';
    stdout.write(
      '''

    ${lightMagenta.wrap('Found $questionLength $rightTermine:')}
    ''',
    );
    for (var i = 0; i < questionLength; i++) {
      var id = '${lightYellow.wrap('@${question.items![i].questionId}')}';
      var title = '${lightGreen.wrap('"${question.items![i].title}"')}';
      var link = '${lightBlue.wrap('${question.items![i].link}')}';
      var tags = '${lightCyan.wrap('${question.items?[i].tags}')}';
      line();
      stdout.write(
        '''
      $id - $title
      Tags: $tags
      See more: $link
        ''',
      );
    }
  }

  void line() {
    empty();
    stdout.write('---------------------------------------------');
    empty();
  }

  void empty() => stdout.write(
        '''
    
      ''',
      );
}
