import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesMultiPopup extends StatefulWidget {
  @override
  _FeaturesMultiPopupState createState() => _FeaturesMultiPopupState();
}

class _FeaturesMultiPopupState extends State<FeaturesMultiPopup> {

  List _fruit = ['mel'];
  List _framework = ['flu'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect.popup(
          title: 'Fruit',
          value: _fruit,
          isTwoLine: true,
          option: SmartSelectOption(
            options.fruits,
            isMultiChoice: true,
          ),
          leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.shopping_cart),
          ),
          onChange: (val) => setState(() => _fruit = val),
        ),
        Divider(indent: 20),
        SmartSelect.popup(
          title: 'Frameworks',
          value: _framework,
          option: SmartSelectOption(
            options.frameworks,
            isMultiChoice: true,
          ),
          builder: (context, state, showOptions) {
            return ListTile(
              title: Text(state.title),
              subtitle: Text(
                state.valueDisplay,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  _framework.length.toString(),
                  style: TextStyle(color: Colors.white)
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => showOptions(context),
            );
          },
          onChange: (val) => setState(() => _framework = val),
        ),
        Container(height: 7),
      ],
    );
  }
}