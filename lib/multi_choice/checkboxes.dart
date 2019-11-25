import 'package:flutter/material.dart';

class SmartSelectCheckboxes extends StatefulWidget {

  final dynamic value;
  final List<Map<String,dynamic>> options;

  SmartSelectCheckboxes({
    Key key,
    @required this.value,
    @required this.options,
  }) : super(key: key);

  @override
  SmartSelectCheckboxesState createState() => SmartSelectCheckboxesState();
}

class SmartSelectCheckboxesState extends State<SmartSelectCheckboxes> {

  List _selectedList;

  @override
  void initState() {
    super.initState();

    // initial load value
    _selectedList = List.from(widget.value);
  }

  List get selectedList => _selectedList;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        itemCount: widget.options.length,
        itemBuilder: (BuildContext context, int i) {
          Map<String,dynamic> item = widget.options[i];
          return CheckboxListTile(
            title: Text(item['label']),
            value: _selectedList.contains(item['value']),
            onChanged: (value) {
              setState(() {
                if (value) {
                  _selectedList.add(item['value']);
                } else {
                  _selectedList.remove(item['value']);
                }
              });
            },
          );
        }
      ),
    );
  }
}