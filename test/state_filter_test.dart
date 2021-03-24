import 'package:flutter_test/flutter_test.dart';
import 'package:smart_select/src/state/filter.dart';

void main() {
  group('Single Choice', () {
    // the state model
    late S2Filter model;
    // the listener call counter
    late int counter;

    setUp(() {
      counter = 0;
      model = S2Filter()
        ..addListener(() {
          counter += 1;
        });
    });

    test('model should start at with query null and activated false', () {
      expect(model.activated, false);
      expect(model.value, null);
      expect(counter, 0);
    });

    test('changes query value', () {
      model.apply('filter query');
      expect(model.value, 'filter query');
    });
  });
}
