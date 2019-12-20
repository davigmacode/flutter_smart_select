import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesModalShape extends StatefulWidget {
  @override
  _FeaturesModalShapeState createState() => _FeaturesModalShapeState();
}

class _FeaturesModalShapeState extends State<FeaturesModalShape> {

  String _framework = 'flu';
  List _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Frameworks',
          value: _framework,
          option: SmartSelectOptionConfig(options.frameworks),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.popupDialog,
            useHeader: false,
            style: SmartSelectModalStyle(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
            ),
          ),
          choice: SmartSelectChoiceConfig(
            type: SmartSelectChoiceType.radios,
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${_framework[0]}',
              style: TextStyle(color: Colors.white)
            ),
          ),
          onChange: (val) => setState(() => _framework = val),
        ),
        Divider(indent: 20),
        SmartSelect(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(options.heroes),
          choice: SmartSelectChoiceConfig(
            type: SmartSelectChoiceType.switches,
          ),
          modal: SmartSelectModalConfig(
            type: SmartSelectModalType.bottomSheet,
            style: SmartSelectModalStyle(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)
                ),
              ),
            ),
            headerStyle: SmartSelectModalHeaderStyle(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)
                ),
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
          ),
          onChange: (val) => setState(() => _hero = val),
        ),
        Container(height: 7),
      ],
    );
  }
}