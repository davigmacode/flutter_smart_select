import 'package:flutter/material.dart';

class SmartSelectRadios extends StatefulWidget {

  final dynamic value;
  final List<Map<String,dynamic>> options;
  final bool closeOnSelect;

  SmartSelectRadios({
    Key key,
    this.value,
    this.options,
    this.closeOnSelect = true,
  }) : super(key: key);

  @override
  SmartSelectRadiosState createState() => SmartSelectRadiosState();
}

class SmartSelectRadiosState extends State<SmartSelectRadios> {

  dynamic _selected;

  @override
  void initState() {
    super.initState();

    // initial load value
    _selected = widget.value;
  }

  get selected => _selected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      itemCount: widget.options.length,
      itemBuilder: (BuildContext context, int i) {
        Map<String,dynamic> item = widget.options[i];
        return RadioListTile(
          title: Text(item['label']),
          value: item['value'],
          groupValue: _selected,
          onChanged: (value) {
            if (widget.closeOnSelect) {
              Navigator.of(context).pop(value);
            } else {
              setState(() => _selected = value);
            }
          },
        );
      }
    );
  }
}