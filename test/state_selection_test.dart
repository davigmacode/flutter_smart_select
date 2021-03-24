import 'package:flutter_test/flutter_test.dart';
import 'package:smart_select/smart_select.dart';
import 'package:smart_select/src/state/selection.dart';

void main() {
  group('Single Choice', () {
    // the state model
    late S2SingleSelection<String> model;
    // the listener call counter
    late int counter;
    // choice to select
    S2Choice<String> choiceToSelect =
        S2Choice<String>(value: 'new-value', title: 'New Value');

    setUp(() {
      counter = 0;
      model = S2SingleSelection<String>(initial: null)
        ..addListener(() {
          counter += 1;
        });
    });

    test('model value should start at null', () {
      expect(model.choice, null);
      expect(counter, 0);
    });

    test('model length should start at 0', () {
      expect(model.length, 0);
      expect(counter, 0);
    });

    test('overwrites the value and calls listeners', () {
      expect(model.choice, null);
      expect(model.length, 0);
      expect(counter, 0);
      model.choice = choiceToSelect;
      expect(model.choice, choiceToSelect);
      expect(model.has(choiceToSelect), true);
      expect(model.length, 1);
      expect(counter, 1);
    });

    test('commits new value and calls listeners', () {
      expect(model.choice, null);
      expect(model.length, 0);
      expect(counter, 0);
      model.select(choiceToSelect);
      expect(model.choice, choiceToSelect);
      expect(model.has(choiceToSelect), true);
      expect(model.length, 1);
      expect(counter, 1);
    });
  });

  group('Multiple Choice', () {
    // the state model
    late S2MultiSelection<int> model;
    // the listener call counter
    late int counter;
    // choice to select
    List<S2Choice<int>> choiceToSelect = S2Choice.listFrom<int, int>(
      source: <int>[2, 4, 7],
      value: (i, v) => v,
      title: (i, v) => v.toString(),
    );

    setUp(() {
      counter = 0;
      model = S2MultiSelection<int>(initial: null)
        ..addListener(() {
          counter += 1;
        });
    });

    test('model value should start at empty array', () {
      expect(model.choice, <int>[]);
      expect(counter, 0);
    });

    test('model length should start at 0', () {
      expect(model.length, 0);
      expect(counter, 0);
    });

    test('overwrites the value and calls listeners', () {
      expect(model.choice, <int>[]);
      expect(model.length, 0);
      expect(counter, 0);
      model.choice = choiceToSelect;
      expect(model.choice, choiceToSelect);
      expect(model.has(choiceToSelect[1]), true);
      expect(model.length, 3);
      expect(counter, 1);
    });

    test('commits new value and calls listeners', () {
      expect(model.choice, <int>[]);
      expect(model.length, 0);
      expect(counter, 0);
      model.select(choiceToSelect[2], selected: true);
      model.select(choiceToSelect[0], selected: true);
      model.select(choiceToSelect[1], selected: false); // ignored
      model.select(choiceToSelect[1], selected: true);
      model.select(choiceToSelect[2], selected: false); // removed
      expect(model.choice, List.from(choiceToSelect)..removeAt(2));
      expect(model.has(choiceToSelect[1]), true);
      expect(model.length, 2);
      expect(counter, 5);
    });
  });
}
