import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesModalValidation extends StatefulWidget {
  @override
  _FeaturesModalValidationState createState() => _FeaturesModalValidationState();
}

class _FeaturesModalValidationState extends State<FeaturesModalValidation> {

  List<String> _fruit;

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
          modalHeaderBuilder: (context, state) {
            return Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              height: kToolbarHeight,
              child: Row(
                children: <Widget>[
                  state.modalTitle,
                  const Spacer(),
                  Visibility(
                    visible: state.changes.valid,
                    child: const Text(
                      'Select at least one',
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                  ),
                ],
              ),
            );
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
        const SizedBox(height: 7),
      ],
    );
  }
}