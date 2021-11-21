import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesModalValidation extends StatefulWidget {
  @override
  _FeaturesModalValidationState createState() =>
      _FeaturesModalValidationState();
}

class _FeaturesModalValidationState extends State<FeaturesModalValidation> {
  String? _day;
  List<String>? _days = ['fri'];
  List<String>? _fruit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Days',
          selectedValue: _day,
          onChange: (selected) => setState(() => _day = selected.value),
          choiceItems: choices.days,
          modalType: S2ModalType.bottomSheet,
          modalValidation: (chosen) {
            return chosen.isEmpty ? 'Select at least one' : '';
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Days',
          selectedValue: _days,
          onChange: (selected) => setState(() => _days = selected?.value),
          choiceItems: choices.days,
          modalType: S2ModalType.bottomSheet,
          modalValidation: (chosen) {
            return chosen.isNotEmpty ? '' : 'Select at least one';
          },
          modalConfirm: true,
          modalFilter: true,
          choiceTitleBuilder: (context, state, choice) {
            return S2Text(
              text: choice.title,
              style: TextStyle(
                color: choice.selected ? Theme.of(context).primaryColor : null,
              ),
              highlight: state.filter?.value,
              highlightColor: Theme.of(context).primaryColor.withOpacity(.7),
            );
          },
          tileBuilder: (context, state) {
            return S2Tile<dynamic>(
              title: state.titleWidget,
              value: state.selected?.toWidget() ?? Container(),
              onTap: state.showModal,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/xsGxhtAsfSA/100x100',
                ),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          selectedValue: _fruit,
          onChange: (selected) => setState(() => _fruit = selected?.value),
          choiceItems: choices.fruits,
          modalType: S2ModalType.popupDialog,
          modalConfirm: true,
          modalValidation: (chosen) {
            return chosen.length > 0 ? '' : 'Select at least one';
          },
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
                    visible: !(state.selection?.isValid ?? true),
                    child: Text(
                      state.selection?.error ?? '',
                      style: TextStyle(color: Colors.red),
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
                    label: Text('OK (${state.selection?.length ?? 0})'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: (state.selection?.isValid ?? true)
                        ? () => state.closeModal(confirmed: true)
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
