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
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          value: _fruit,
          options: options.fruits,
          onChange: (state) => setState(() => _fruit = state.value),
          modalType: S2ModalType.popupDialog,
          title: 'Fruit',
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              leading: const Icon(Icons.shopping_cart),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.single(
          value: _framework,
          options: options.frameworks,
          title: 'Frameworks',
          modalType: S2ModalType.popupDialog,
          onChange: (state) => setState(() => _framework = state.value),
          tileBuilder: (context, state) {
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
              trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: state.showModal,
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}