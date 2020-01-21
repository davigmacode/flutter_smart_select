import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesSinglePopup extends StatefulWidget {
  @override
  _FeaturesSinglePopupState createState() => _FeaturesSinglePopupState();
}

class _FeaturesSinglePopupState extends State<FeaturesSinglePopup> {

  String _fruit = 'mel';
  String _framework = 'flu';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Fruit',
          value: _fruit,
          options: options.fruits,
          leading: const Icon(Icons.shopping_cart),
          onChange: (val) => setState(() => _fruit = val),
          modalType: SmartSelectModalType.popupDialog,
        ),
        Divider(indent: 20),
        SmartSelect<String>.single(
          title: 'Frameworks',
          value: _framework,
          options: options.frameworks,
          modalType: SmartSelectModalType.popupDialog,
          builder: (context, state, showOption) {
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
                  '${state.valueDisplay[0]}',
                  style: TextStyle(color: Colors.white)
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => showOption(context),
            );
          },
          onChange: (val) => setState(() => _framework = val),
        ),
        Container(height: 7),
      ],
    );
  }
}