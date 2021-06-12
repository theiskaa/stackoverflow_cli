/// API class which provides customizable api urls.
class Api {
  static const questions = 'https://api.stackexchange.com/2.2/questions?';

  /// Get right quesiton's api url.
  String get({
    String? order = 'desc',
    String? sort = 'activity',
    int? limit = 5,
    int? id,
    List<String>? tags = const [],
  }) {
    if (id != null) {
      return '${questions.replaceAll('?', '/')}$id?order=$order&sort=$sort&site=stackoverflow';
    }
    if (tags != null) {
      return '${questions}pagesize=$limit&order=$order&sort=$sort&tagged=$tags&site=stackoverflow';
    }
    return '${questions}pagesize=$limit&order=$order&sort=$sort&site=stackoverflow';
  }
}
