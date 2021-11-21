import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import '../choices.dart' as choices;

class FeaturesMultiPopup extends StatefulWidget {
  @override
  _FeaturesMultiPopupState createState() => _FeaturesMultiPopupState();
}

class _FeaturesMultiPopupState extends State<FeaturesMultiPopup> {
  List<String>? _fruit = ['mel'];
  List<String>? _framework = ['flu'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.multiple(
          title: 'Fruit',
          selectedValue: _fruit,
          onChange: (selected) => setState(() => _fruit = selected?.value),
          choiceItems: choices.fruits,
          modalType: S2ModalType.popupDialog,
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
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Frameworks',
          selectedValue: _framework,
          onChange: (selected) {
            setState(() => _framework = selected?.value);
          },
          choiceItems: choices.frameworks,
          modalType: S2ModalType.popupDialog,
          tileBuilder: (context, state) {
            return ListTile(
              title: Text(state.title ?? ''),
              subtitle: Text(
                state.selected.toString(),
                style: const TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  (state.selected?.length ?? 0).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: state.showModal,
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
