/// API class which provides customizable api urls.
class Api {
  static const questions = 'https://api.stackexchange.com/2.2/questions?';
  static const searchUrl = 'https://api.stackexchange.com/2.2/search?';

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

  // Get right search url.
  String search({
    required String inTitle,
    String? order = 'desc',
    String? sort = 'activity',
    int? limit = 0,
    List<String>? tags = const [],
  }) {
    if (limit != 0 && tags == null) {
      return '${searchUrl}pagesize=$limit&order=$order&sort=$sort&intitle=$inTitle&site=stackoverflow';
    }
    if (tags != null && limit == 0) {
      return '${searchUrl}order=$order&sort=$sort&tagged=$tags&intitle=$inTitle&site=stackoverflow';
    }
    if (tags != null && limit != 0) {
      return '${searchUrl}pagesize=$limit&order=$order&sort=$sort&tagged=$tags&intitle=$inTitle&site=stackoverflow';
    }
    return '${searchUrl}order=$order&sort=$sort&intitle=$inTitle&site=stackoverflow';
  }
}
