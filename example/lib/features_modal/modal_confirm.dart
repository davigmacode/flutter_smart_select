import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../choices.dart' as choices;

class FeaturesModalConfirm extends StatefulWidget {
  @override
  _FeaturesModalConfirmState createState() => _FeaturesModalConfirmState();
}

class _FeaturesModalConfirmState extends State<FeaturesModalConfirm> {

  List<String> _day = ['fri'];
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
          modalConfirmation: true,
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
        SmartSelect<String>.single(
          title: 'Super Hero',
          value: _hero,
          onChange: (state) => setState(() => _hero = state.value),
          choiceItems: choices.heroes,
          choiceStyle: const S2ChoiceStyle(
            activeColor: Colors.redAccent
          ),
          modalType: S2ModalType.bottomSheet,
          modalConfirmation: true,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
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