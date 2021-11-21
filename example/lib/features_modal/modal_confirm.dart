import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

import '../choices.dart' as choices;

class FeaturesModalConfirm extends StatefulWidget {
  @override
  _FeaturesModalConfirmState createState() => _FeaturesModalConfirmState();
}

class _FeaturesModalConfirmState extends State<FeaturesModalConfirm> {
  List<String>? _day = ['fri'];
  List<String>? _fruit = ['mel'];
  String? _hero = 'iro';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          selectedValue: _day,
          onChange: (selected) => setState(() => _day = selected?.value),
          choiceItems: choices.days,
          modalType: S2ModalType.fullPage,
          modalConfirm: true,
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
          modalValidation: (value) {
            return value.length > 0 ? '' : 'Select at least one';
          },
          modalHeaderStyle: S2ModalHeaderStyle(
            backgroundColor: Theme.of(context).cardColor,
          ),
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
            return [];
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
                    child: Text('OK (${state.selection?.length ?? 0})'),
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
        const Divider(indent: 20),
        SmartSelect<String?>.single(
          title: 'Super Hero',
          selectedValue: _hero,
          onChange: (selected) => setState(() => _hero = selected.value),
          choiceItems: choices.heroes,
          choiceActiveStyle: const S2ChoiceStyle(color: Colors.redAccent),
          modalType: S2ModalType.bottomSheet,
          modalValidation: (selected) {
            if (selected == null) return 'Select at least one';
            if (selected.value == 'iro') return 'Ironman is busy';
            return '';
          },
          modalConfig: S2ModalConfig(
            useConfirm: true,
            confirmLabel: const Text('Send'),
            confirmIcon: const Icon(Icons.send),
          ),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/8I-ht65iRww/100x100',
                ),
              ),
            );
          },
          modalConfirmBuilder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: FlatButton(
                  child: const Text('Send'),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: () => state.closeModal(confirmed: true),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
