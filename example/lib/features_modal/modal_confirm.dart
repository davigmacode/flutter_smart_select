import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesModalConfirm extends StatefulWidget {
  @override
  _FeaturesModalConfirmState createState() => _FeaturesModalConfirmState();
}

class _FeaturesModalConfirmState extends State<FeaturesModalConfirm> {

  List<String> _day = ['fri'];
  List<String> _fruit = ['mel'];
  String _hero = 'iro';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Days',
          value: _day,
          onChange: (state) => setState(() => _day = state.value),
          choiceItems: choices.days,
          modalType: S2ModalType.fullPage,
          modalConfirm: true,
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
                    child: Text('OK (${state.changes.length})'),
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
        const Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Super Hero',
          value: _hero,
          onChange: (state) => setState(() => _hero = state.value),
          choiceItems: choices.heroes,
          choiceActiveStyle: const S2ChoiceStyle(
            color: Colors.redAccent
          ),
          modalType: S2ModalType.bottomSheet,
          modalValidation: (value) {
            if (value.length == 0) return 'Select at least one';
            if (value == 'iro') return 'Ironman is busy';
            return null;
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
                backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
              ),
            );
          },
          // modalConfirmBuilder: (context, state) {
          //   return Center(
          //     child: Padding(
          //       padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          //       child: FlatButton(
          //         child: const Text('Send'),
          //         color: Colors.redAccent,
          //         textColor: Colors.white,
          //         onPressed: () => state.closeModal(confirmed: true),
          //       ),
          //     ),
          //   );
          // },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}