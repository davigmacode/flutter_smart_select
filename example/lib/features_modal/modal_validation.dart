import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesModalValidation extends StatefulWidget {
  @override
  _FeaturesModalValidationState createState() => _FeaturesModalValidationState();
}

class _FeaturesModalValidationState extends State<FeaturesModalValidation> {

  String _day;
  List<String> _days = ['fri'];
  List<String> _fruit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Days',
          value: _day,
          onChange: (state) => setState(() => _day = state.value),
          choiceItems: choices.days,
          modalType: S2ModalType.bottomSheet,
          modalValidation: (value) => value == null ? 'Select at least one' : null,
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _days,
          onChange: (state) => setState(() => _days = state.value),
          choiceItems: choices.days,
          modalType: S2ModalType.bottomSheet,
          modalValidation: (value) => value.length > 0 ? null : 'Select at least one',
          modalConfirm: true,
          modalFilter: true,
          choiceTitleBuilder: (context, item, filter) {
            return S2Text(
              text: item.title,
              style: TextStyle(
                color: item.selected ? Theme.of(context).primaryColor : null
              ),
              highlight: filter,
              highlightColor: Theme.of(context).primaryColor.withOpacity(.7),
            );
          },
          tileBuilder: (context, state) {
            return S2Tile(
              title: state.titleWidget,
              value: state.valueDisplay,
              onTap: state.showModal,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              ),
            );
          }
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          value: _fruit,
          onChange: (state) => setState(() => _fruit = state.value),
          choiceItems: choices.fruits,
          modalType: S2ModalType.popupDialog,
          modalConfirm: true,
          modalValidation: (value) => value.length > 0 ? null : 'Select at least one',
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
                    visible: !state.changes.valid,
                    child: Text(
                      state.changes?.error ?? '',
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
                  FlatButton.icon(
                    icon: Icon(Icons.check),
                    label: Text('OK (${state.changes.length})'),
                    color: Theme.of(context).primaryColor,
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