import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesModalSelector extends StatefulWidget {
  @override
  _FeaturesModalSelectorState createState() => _FeaturesModalSelectorState();
}

class _FeaturesModalSelectorState extends State<FeaturesModalSelector> {

  List<String> _fruit = ['mel'];
  List<String> _smartphone = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          value: _fruit,
          onChange: (state) => setState(() => _fruit = state.value),
          choiceItems: choices.fruits,
          modalType: S2ModalType.popupDialog,
          modalConfirmation: true,
          modalValidation: (value) => value.length > 0,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: Container(
                width: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.shopping_cart),
              ),
            );
          },
          modalActionsBuilder: (context, state) {
            return <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: state.choiceSelector,
              )
            ];
          },
          modalDividerBuilder: (context, state) {
            return const Divider(height: 1);
          },
          modalFooterBuilder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 7.0,
              ),
              child: Row(
                children: <Widget>[
                  const Spacer(),
                  FlatButton(
                    child: const Text('Cancel'),
                    onPressed: () => state.closeModal(confirmed: false),
                  ),
                  const SizedBox(width: 5),
                  FlatButton(
                    child: Text('OK (${state.changes.length})'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: state.changes.valid
                      ? () => state.closeModal(confirmed: true)
                      : null,
                  ),
                ],
              ),
            );
          }
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Phones',
          placeholder: 'Choose one',
          value: _smartphone,
          onChange: (state) => setState(() => _smartphone = state.value),
          choiceItems: S2Choice.listFrom<String, Map>(
            source: choices.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
            meta: (index, item) => item,
          ),
          choiceType: S2ChoiceType.chips,
          modalType: S2ModalType.bottomSheet,
          modalActionsBuilder: (context, state) {
            return [
              ActionButton(
                label: const Text('Low End'),
                onTap: () {
                  state.changes.value = state.widget.choiceItems
                    .where((item) => item.meta['category'] == 'Budget Phone')
                    .map((item) => item.value)
                    .toList();
                },
              ),
              ActionButton(
                label: const Text('Mid End'),
                onTap: () {
                  state.changes.value = state.widget.choiceItems
                    .where((item) => item.meta['category'] == 'Mid End Phone')
                    .map((item) => item.value)
                    .toList();
                },
              ),
              ActionButton(
                label: const Text('High End'),
                onTap: () {
                  state.changes.value = state.widget.choiceItems
                    .where((item) => item.meta['category'] == 'Flagship Phone')
                    .map((item) => item.value)
                    .toList();
                },
              ),
            ];
          },
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              ),
            );
          }
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {

  final Widget label;
  final VoidCallback onTap;

  ActionButton({
    Key key,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: FlatButton(
          child: label,
          color: Colors.redAccent,
          textColor: Colors.white,
          onPressed: onTap,
        ),
      ),
    );
  }
}