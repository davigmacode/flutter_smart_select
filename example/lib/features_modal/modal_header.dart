import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../widgets/icon_badge.dart';
import '../choices.dart' as choices;

class FeaturesModalHeader extends StatefulWidget {
  @override
  _FeaturesModalHeaderState createState() => _FeaturesModalHeaderState();
}

class _FeaturesModalHeaderState extends State<FeaturesModalHeader> {
  List<String>? _month = ['apr'];
  String? _framework = 'flu';
  List<String>? _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Month',
          selectedValue: _month,
          onChange: (selected) => setState(() => _month = selected?.value),
          choiceItems: choices.months,
          choiceActiveStyle: const S2ChoiceStyle(color: Colors.red),
          modalFilter: true,
          modalHeaderStyle: const S2ModalHeaderStyle(
            elevation: 4,
            centerTitle: true,
            backgroundColor: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: IconBadge(
                icon: const Icon(Icons.calendar_today),
                counter: state.selected?.length ?? 0,
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String?>.single(
          title: 'Frameworks',
          selectedValue: _framework,
          onChange: (selected) {
            setState(() => _framework = selected.value);
          },
          choiceItems: choices.frameworks,
          modalConfig: S2ModalConfig(
            type: S2ModalType.popupDialog,
            headerStyle: S2ModalHeaderStyle(
              backgroundColor: Theme.of(context).primaryColor,
              textStyle: Theme.of(context).primaryTextTheme.headline6,
              centerTitle: true,
              elevation: 0,
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
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Super Hero',
          selectedValue: _hero,
          onChange: (selected) => setState(() => _hero = selected?.value),
          choiceItems: choices.heroes,
          modalType: S2ModalType.bottomSheet,
          modalStyle: S2ModalStyle(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0),
              ),
            ),
          ),
          modalHeaderBuilder: (context, state) {
            return Column(
              children: [
                Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                  ),
                ),
                state.modalTitle,
                SizedBox(height: 15),
              ],
            );
          },
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
