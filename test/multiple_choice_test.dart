import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:awesome_select/awesome_select.dart';
import 'choices.dart' as choices;

void main() {
  testSmartSelect(
    title:
        'Full page modal, default tile and radio choices displayed correctly',
    initialChoice: [],
    choiceToSelect: [
      choices.days[3],
      choices.days[0],
    ],
    choiceItems: choices.days,
    modalType: S2ModalType.fullPage,
    choiceType: S2ChoiceType.checkboxes,
  );

  testSmartSelect(
    title:
        'Bottomsheet modal, default tile and chips choices displayed correctly',
    placeholder: 'Pilih Salah Satu',
    initialChoice: [],
    choiceToSelect: [
      choices.heroes[1],
      choices.heroes[2],
    ],
    choiceItems: choices.heroes,
    modalType: S2ModalType.popupDialog,
    choiceType: S2ChoiceType.chips,
  );
}

void testSmartSelect<T>({
  required String title,
  required List<S2Choice<T>> initialChoice,
  required List<S2Choice<T>> choiceToSelect,
  required List<S2Choice<T>> choiceItems,
  S2ModalType modalType = S2ModalType.fullPage,
  S2ChoiceType? choiceType,
  String placeholder = 'Select one or more',
}) {
  List<S2Choice<T>>? selectedChoice = initialChoice;

  testWidgets(title, (WidgetTester tester) async {
    await tester.pumpWidget(
      Bootstrap(
        child: SmartSelect<T>.multiple(
          title: title,
          placeholder: placeholder,
          selectedValue: selectedChoice?.map((e) => e.value).toList(),
          choiceItems: choiceItems,
          modalType: modalType,
          choiceType: choiceType,
          onChange: (selected) => selectedChoice = selected!.choice,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final s2Finder = find.byWidgetPredicate((widget) {
      return widget is SmartSelect<T>;
    });
    expect(
      s2Finder,
      findsOneWidget,
      reason: 'SmartSelect widget is displayed',
    );

    final s2State = tester.state<S2MultiState<T>>(s2Finder);
    expect(
      s2State.selected!.choice,
      initialChoice,
      reason: 'Initial choice is correct',
    );
    expect(
      s2State.selected!.value,
      initialChoice.map((e) => e.value).toList(),
      reason: 'Initial value is correct',
    );

    final tileFinder = find.descendant(
      of: s2Finder,
      matching: find.byWidgetPredicate((widget) => widget is S2Tile),
    );
    expect(tileFinder, findsOneWidget, reason: 'Trigger tile displayed');
    final tileTitleFinder = find.descendant(
      of: s2Finder,
      matching: find.text(title),
    );
    expect(
      tileTitleFinder,
      findsOneWidget,
      reason: 'Tile title displayed',
    );

    final tileValueFinder = find.descendant(
      of: s2Finder,
      matching: find.text(s2State.selected.toString()),
    );
    expect(
      tileValueFinder,
      findsOneWidget,
      reason: 'Tile value displayed',
    );

    // Open the choice modal
    await tester.tap(tileFinder);
    // Rebuild the widget after the state has changed.
    await tester.pumpAndSettle();

    final modalFinder = find.byWidgetPredicate((widget) {
      if (modalType == S2ModalType.popupDialog)
        return widget is Dialog;
      else if (modalType == S2ModalType.bottomSheet)
        return widget is BottomSheet;
      else
        return widget is Scaffold;
    });
    expect(
      modalFinder,
      findsOneWidget,
      reason: 'Modal displayed',
    );

    final choiceWrapperFinder = find.byWidgetPredicate((widget) {
      if (choiceType == S2ChoiceType.chips)
        return widget is Wrap;
      else
        return widget is ListView;
    });
    expect(
      choiceWrapperFinder,
      findsOneWidget,
      reason: 'Choice items wrapper displayed',
    );

    final choiceItemsFinder = find.byWidgetPredicate((widget) {
      if (choiceType == S2ChoiceType.checkboxes)
        return widget is CheckboxListTile;
      else if (choiceType == S2ChoiceType.chips)
        return widget is RawChip;
      else if (choiceType == S2ChoiceType.switches)
        return widget is SwitchListTile;
      else
        return widget is Card;
    });
    expect(
      choiceItemsFinder,
      findsNWidgets(choiceItems.length),
      reason: 'List of choice items displayed',
    );
    for (var choice in choiceToSelect) {
      final choiceToSelectFinder = find.byKey(ValueKey(choice.value));
      expect(
        choiceToSelectFinder,
        findsOneWidget,
        reason: 'Choice to select displayed',
      );

      // Select a choice
      await tester.tap(choiceToSelectFinder);
      // Rebuild the widget after the state has changed.
      await tester.pumpAndSettle();
    }

    // Close the modal
    // await tester.pageBack();
    s2State.closeModal(confirmed: true);
    // Rebuild the widget after the state has changed.
    await tester.pumpAndSettle();

    expect(
      s2State.selected!.choice,
      choiceToSelect,
      reason: 'New selected choice to internal choice is correct',
    );
    expect(
      selectedChoice,
      choiceToSelect,
      reason: 'New selected choice to external choice is correct',
    );

    expect(
      s2State.selected!.value,
      choiceToSelect.map((e) => e.value).toList(),
      reason: 'New selected value to internal value is correct',
    );
    expect(
      selectedChoice?.map((e) => e.value).toList(),
      choiceToSelect.map((e) => e.value).toList(),
      reason: 'New selected value to external value is correct',
    );
  });
}

class Bootstrap extends StatelessWidget {
  final Widget child;

  const Bootstrap({
    Key? key,
    required this.child,
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
