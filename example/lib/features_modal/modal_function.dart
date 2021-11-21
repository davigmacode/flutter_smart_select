import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

class ProgrammaticModal extends StatefulWidget {
  @override
  _ProgrammaticModalState createState() => _ProgrammaticModalState();
}

class _ProgrammaticModalState extends State<ProgrammaticModal> {
  List<S2Choice<String>> _choices = [
    S2Choice<String>(value: 'app', title: 'Apple'),
    S2Choice<String>(value: 'ore', title: 'Orange'),
    S2Choice<String>(value: 'mel', title: 'Melon'),
  ];

  List<String>? _value;
  GlobalKey<S2MultiState<String>> _smartSelectKey =
      GlobalKey<S2MultiState<String>>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _smartSelectKey.currentState?.showModal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
      key: _smartSelectKey,
      title: 'Fruit',
      selectedValue: _value,
      onChange: (selected) => setState(() => _value = selected?.value),
      choiceItems: _choices,
      tileBuilder: (context, state) {
        return Container();
      },
    );
  }
}
