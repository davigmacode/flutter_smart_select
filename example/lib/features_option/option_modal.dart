import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesOptionModal extends StatefulWidget {
  @override
  _FeaturesOptionModalState createState() => _FeaturesOptionModalState();
}

class _FeaturesOptionModalState extends State<FeaturesOptionModal> {

  String _framework = 'flu';
  List _hero = ['bat', 'spi'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect.popup(
          title: 'Frameworks',
          value: _framework,
          option: SmartSelectOption(
            options.frameworks,
            elevation: 3,
            useHeader: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
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
        SmartSelect.sheet(
          title: 'Super Hero',
          value: _hero,
          isTwoLine: true,
          option: SmartSelectOption(
            options.heroes,
            isMultiChoice: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0)
              ),
            ),
            headerTheme: SmartSelectOptionHeaderTheme(
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