import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

class FeaturesModalWidget extends StatefulWidget {
  @override
  _FeaturesModalWidgetState createState() => _FeaturesModalWidgetState();
}

class _FeaturesModalWidgetState extends State<FeaturesModalWidget> {
  int? _question1;
  List<int>? _question2;

  List<String> _options1 = [
    'Very Satisfied',
    'Somewhat Satisfied',
    'Neither Satisfied or Dissatisfied',
    'Somewhat Dissatisfied',
    'Very Dissatisfied',
  ];
  List<String> _options2 = [
    'Reliable',
    'High Quality',
    'Usefull',
    'Unique',
    'Impractical',
    'Ineffective',
    'Poor Quality',
    'Unreliable',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<int?>.single(
          title:
              'Overall, how satisfied are you with flutter_awesome_select package?',
          selectedValue: _question1,
          onChange: (selected) {
            setState(() => _question1 = selected.value);
          },
          choiceType: S2ChoiceType.radios,
          choiceItems: S2Choice.listFrom<int, String>(
            source: _options1,
            value: (i, v) => i,
            title: (i, v) => v,
          ),
          modalConfig: S2ModalConfig(
            type: S2ModalType.popupDialog,
            style: S2ModalStyle(
              elevation: 3,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
            ),
          ),
          tileBuilder: (context, state) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 15,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: S2Tile.fromState(
                  state,
                  hideValue: true,
                  leading: CircleAvatar(
                    backgroundColor: _question1 == null
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          modalHeaderBuilder: (context, state) {
            return Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: state.modalTitle,
            );
          },
        ),
        SmartSelect<int>.multiple(
          title:
              'Which of following words would you use to describe flutter_awesome_select?',
          selectedValue: _question2,
          onChange: (selected) {
            setState(() => _question2 = selected?.value);
          },
          choiceItems: S2Choice.listFrom<int, String>(
            source: _options2,
            value: (i, v) => i,
            title: (i, v) => v,
          ),
          choiceConfig: S2ChoiceConfig(
            type: S2ChoiceType.checkboxes,
            layout: S2ChoiceLayout.grid,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.5,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              crossAxisCount: 2,
            ),
            style: S2ChoiceStyle(
              control: S2ChoiceControl.leading,
            ),
          ),
          modalConfirm: true,
          modalType: S2ModalType.bottomSheet,
          modalValidation: (value) {
            return value.length > 0 ? '' : 'Select at least one';
          },
          modalHeaderBuilder: (context, state) {
            return Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
              child: state.modalTitle,
            );
          },
          modalFooterBuilder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: FlatButton(
                  child: Text('Submit (${state.selection?.length})'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: (state.selection?.isValid ?? true)
                      ? () => state.closeModal(confirmed: true)
                      : null,
                ),
              ),
            );
          },
          tileBuilder: (context, state) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 15,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: S2Tile.fromState(
                  state,
                  hideValue: true,
                  leading: CircleAvatar(
                    backgroundColor: _question2 == null
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: S2TileChips(
                    chipLength: state.selected?.length ?? 0,
                    chipLabelBuilder: (context, i) {
                      return Text(state.selected?.choice?[i].title ?? '');
                    },
                    chipColor: Theme.of(context).primaryColor,
                    chipRaised: true,
                    // placeholder: Container(),
                  ),
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
