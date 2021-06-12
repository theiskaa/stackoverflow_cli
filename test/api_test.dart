import 'package:scli/scli.dart';
import 'package:test/test.dart';

void main() {
  var api = Api();
  group('[Api]', () {
    test('get', () {
      var defaultPath =
          '${Api.questions}pagesize=5&order=desc&sort=activity&site=stackoverflow';
      var idProvidedPath =
          '${Api.questions.replaceAll('?', '/')}666?order=desc&sort=activity&site=stackoverflow';
      var tagsProvidedPath =
          '${Api.questions}pagesize=5&order=desc&sort=activity&tagged=[flutter]&site=stackoverflow';

      expect(api.get(tags: null), defaultPath);
      expect(api.get(id: 666), idProvidedPath);
      expect(api.get(tags: ['flutter']), tagsProvidedPath);
    });

    test('search', () {
      var defaultPath =
          '${Api.searchUrl}order=desc&sort=activity&intitle=test&site=stackoverflow';
      var limitProvidedPath =
          '${Api.searchUrl}pagesize=1&order=desc&sort=activity&intitle=test&site=stackoverflow';
      var tagsProvidedPath =
          '${Api.searchUrl}order=desc&sort=activity&tagged=[dart]&intitle=test&site=stackoverflow';
      var tagsAndLimitProvidedPath =
          '${Api.searchUrl}pagesize=1&order=desc&sort=activity&tagged=[dart]&intitle=test&site=stackoverflow';

      expect(api.search(inTitle: 'test', tags: null), defaultPath);
      expect(
        api.search(inTitle: 'test', tags: null, limit: 1),
        limitProvidedPath,
      );
      expect(api.search(inTitle: 'test', tags: ['dart']), tagsProvidedPath);
      expect(
        api.search(inTitle: 'test', tags: ['dart'], limit: 1),
        tagsAndLimitProvidedPath,
      );
    });
  });
}
