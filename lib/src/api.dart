/// API class which provides customizable api urls.
class Api {
  static const questions = 'https://api.stackexchange.com/2.2/questions?';

  /// Get right questions apiUrl by customizing it.
  /// But as default gets order by [desc], sort by [activity].
  String get({
    String? order = 'desc',
    String? sort = 'activity',
    int pageSize = 10,
  }) {
    return '${questions}pagesize=$pageSize&order=$order&sort=$sort&site=stackoverflow';
  }
}
