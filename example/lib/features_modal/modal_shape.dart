import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesModalShape extends StatefulWidget {
  @override
  _FeaturesModalShapeState createState() => _FeaturesModalShapeState();
}

class _FeaturesModalShapeState extends State<FeaturesModalShape> {
  String? _framework = 'flu';
  List<String>? _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String?>.single(
          title: 'Frameworks',
          selectedValue: _framework,
          onChange: (selected) {
            setState(() => _framework = selected.value);
          },
          choiceType: S2ChoiceType.radios,
          choiceItems: choices.frameworks,
          modalType: S2ModalType.popupDialog,
          modalHeader: false,
          modalConfig: const S2ModalConfig(
            style: S2ModalStyle(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: CircleAvatar(
                child: Text(
                  '${state.selected.toString()[0]}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          selectedValue: _hero,
          onChange: (selected) => setState(() => _hero = selected?.value),
          choiceItems: choices.heroes,
          choiceType: S2ChoiceType.switches,
          modalType: S2ModalType.bottomSheet,
          modalConfig: const S2ModalConfig(
            style: S2ModalStyle(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
            ),
            headerStyle: S2ModalHeaderStyle(
              centerTitle: true,
            ),
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
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
