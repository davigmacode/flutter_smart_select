import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_select/smart_select.dart';

void main() {

  List<S2Choice<String>> choices = [
    S2Choice<String>(value: 'mon', title: 'Monday'),
    S2Choice<String>(value: 'tue', title: 'Tuesday'),
    S2Choice<String>(value: 'wed', title: 'Wednesday'),
    S2Choice<String>(value: 'thu', title: 'Thursday'),
    S2Choice<String>(value: 'fri', title: 'Friday'),
    S2Choice<String>(value: 'sat', title: 'Saturday'),
    S2Choice<String>(value: 'sun', title: 'Sunday'),
  ];

  String selectedValue;

  S2Choice<String> choiceToSelect = choices[3];

  setUp(() {
    selectedValue = null;
  });

  testWidgets('Default tile, modal and choices displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(Bootstrap(child: SmartSelect<String>.single(
      title: 'Days',
      selectedValue: selectedValue,
      choiceItems: choices,
      onChange: (state) => selectedValue = state.selected.value,
    )));

    final s2Finder = find.byWidgetPredicate((widget) => widget is SmartSelect<String>);
    expect(s2Finder, findsOneWidget, reason: 'SmartSelect widget is displayed');

    final S2SingleState<String> s2State = tester.state<S2SingleState<String>>(s2Finder);
    expect(s2State.selected.value, null, reason: 'Initial value is correct');

    final tileFinder = find.descendant(
      of: s2Finder,
      matching: find.byWidgetPredicate((widget) => widget is S2Tile<String>)
    );
    expect(tileFinder, findsOneWidget, reason: 'Trigger tile displayed');

    final tileTitleFinder = find.descendant(of: s2Finder, matching: find.text('Days'));
    final tileValueFinder = find.descendant(of: s2Finder, matching: find.text('Select one'));
    expect(tileTitleFinder, findsOneWidget, reason: 'Tile title displayed');
    expect(tileValueFinder, findsOneWidget, reason: 'Tile placeholder displayed');

    // Open the choice modal
    await tester.tap(tileFinder);
    // Rebuild the widget after the state has changed.
    await tester.pumpAndSettle();

    final choiceWrapperFinder = find.byType(ListView);
    expect(choiceWrapperFinder, findsOneWidget, reason: 'Choice items wrapper displayed');

    final choiceItemsFinder = find.byWidgetPredicate((widget) => widget is RadioListTile<String>);
    expect(choiceItemsFinder, findsNWidgets(choices.length), reason: 'List of choice items displayed');

    final choiceToSelectFinder = find.byKey(ValueKey(choiceToSelect.value));
    expect(choiceToSelectFinder, findsOneWidget, reason: 'Choice to select displayed');

    // Select a choice
    await tester.tap(choiceToSelectFinder);
    // Rebuild the widget after the state has changed.
    await tester.pumpAndSettle();

    // expect(s2State.selected.value, choiceToSelect.value, reason: 'New selected value to internal value is correct');
    // expect(selectedValue, choiceToSelect.value, reason: 'New selected value to external value is correct');
  });
}

class Bootstrap extends StatelessWidget {
  final Widget child;

  const Bootstrap({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Select Test',
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}