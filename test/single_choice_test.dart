import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_select/smart_select.dart';

void main() {

  String value;
  List<S2Choice<String>> choices = [
    S2Choice<String>(value: 'mon', title: 'Monday'),
    S2Choice<String>(value: 'tue', title: 'Tuesday'),
    S2Choice<String>(value: 'wed', title: 'Wednesday'),
    S2Choice<String>(value: 'thu', title: 'Thursday'),
    S2Choice<String>(value: 'fri', title: 'Friday'),
    S2Choice<String>(value: 'sat', title: 'Saturday'),
    S2Choice<String>(value: 'sun', title: 'Sunday'),
  ];

  setUp(() {
    value = null;
  });

  testWidgets('Default tile, modal and input displayed correctly', (WidgetTester tester) async {
    final s2Widget = SmartSelect<String>.single(
      title: 'Days',
      value: value,
      choiceItems: choices,
      onChange: (state) => value = state.value,
    );

    await tester.pumpWidget(Bootstrap(child: s2Widget));
    await tester.pumpAndSettle();

    final s2Finder = find.byWidget(s2Widget);
    expect(s2Finder, findsOneWidget);

    final S2SingleState<String> s2State = tester.state<S2SingleState<String>>(s2Finder);
    expect(s2State.value, null);

    // expect the tile displayed correctly
    final tileTitleFinder = find.descendant(of: s2Finder, matching: find.text('Days'));
    final tileValueFinder = find.descendant(of: s2Finder, matching: find.text('Select one'));
    expect(tileTitleFinder, findsOneWidget);
    expect(tileValueFinder, findsOneWidget);

    // // Tap the widget
    // await tester.tap(tileTitleFinder);
    // // Rebuild the widget after the state has changed.
    // await tester.pump();

    // final listViewFinder = find.byType(ListView);
    // expect(listViewFinder, findsOneWidget, reason: 'List of items displayed');
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