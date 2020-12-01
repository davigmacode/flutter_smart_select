import 'package:flutter_test/flutter_test.dart';
import 'package:smart_select/src/state/selection.dart';

void main() {
  group('Single Choice', () {
    // the state model
    S2SingleSelection<String> model;
    // the listener call counter
    int counter;

    setUp(() {
      counter = 0;
      model = S2SingleSelection<String>(null)
        ..addListener(() {
          counter += 1;
        });
    });

    test('model value should start at null', () {
      expect(model.value, null);
      expect(counter, 0);
    });

    test('model length should start at 0', () {
      expect(model.length, 0);
      expect(counter, 0);
    });

    test('overwrites the value and calls listeners', () {
      expect(model.value, null);
      expect(model.length, 0);
      expect(counter, 0);
      model.value = 'new-value';
      expect(model.value, 'new-value');
      expect(model.has('new-value'), true);
      expect(model.length, 1);
      expect(counter, 1);
    });

    test('commits new value and calls listeners', () {
      expect(model.value, null);
      expect(model.length, 0);
      expect(counter, 0);
      model.select('new-value');
      expect(model.value, 'new-value');
      expect(model.has('new-value'), true);
      expect(model.length, 1);
      expect(counter, 1);
    });
  });

  group('Multiple Choice', () {
    // the state model
    S2MultiSelection<int> model;
    // the listener call counter
    int counter;

    setUp(() {
      counter = 0;
      model = S2MultiSelection<int>(null)
        ..addListener(() {
          counter += 1;
        });
    });

    test('model value should start at empty array', () {
      expect(model.value, <int>[]);
      expect(counter, 0);
    });

    test('model length should start at 0', () {
      expect(model.length, 0);
      expect(counter, 0);
    });

    test('overwrites the value and calls listeners', () {
      expect(model.value, <int>[]);
      expect(model.length, 0);
      expect(counter, 0);
      model.value = <int>[2, 4, 7];
      expect(model.value, <int>[2, 4, 7]);
      expect(model.has(4), true);
      expect(model.length, 3);
      expect(counter, 1);
    });

    test('commits new value and calls listeners', () {
      expect(model.value, <int>[]);
      expect(model.length, 0);
      expect(counter, 0);
      model.select(3, selected: true);
      model.select(7, selected: true);
      model.select(14, selected: false); // ignored
      model.select(9, selected: true);
      model.select(3, selected: false); // removed
      expect(model.value, <int>[7, 9]);
      expect(model.has(7), true);
      expect(model.length, 2);
      expect(counter, 5);
    });
  });
}
