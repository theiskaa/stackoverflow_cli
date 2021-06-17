import 'package:scli/scli.dart';
import 'package:test/test.dart';

void main() {
  var api = ApiGen();
  group('[Api]', () {
    test('get', () {
      var defaultPath =
          '${ApiGen.questions}pagesize=5&order=desc&sort=activity&site=stackoverflow';
      var idProvidedPath =
          '${ApiGen.questions.replaceAll('?', '/')}666?order=desc&sort=activity&site=stackoverflow';
      var tagsProvidedPath =
          '${ApiGen.questions}pagesize=5&order=desc&sort=activity&tagged=[flutter]&site=stackoverflow';

      expect(api.get(tags: null), defaultPath);
      expect(api.get(id: 666), idProvidedPath);
      expect(api.get(tags: ['flutter']), tagsProvidedPath);
    });

    test('search', () {
      var defaultPath =
          '${ApiGen.searchUrl}order=desc&sort=activity&intitle=test&site=stackoverflow';
      var limitProvidedPath =
          '${ApiGen.searchUrl}pagesize=1&order=desc&sort=activity&intitle=test&site=stackoverflow';
      var tagsProvidedPath =
          '${ApiGen.searchUrl}order=desc&sort=activity&tagged=[dart]&intitle=test&site=stackoverflow';
      var tagsAndLimitProvidedPath =
          '${ApiGen.searchUrl}pagesize=1&order=desc&sort=activity&tagged=[dart]&intitle=test&site=stackoverflow';

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
