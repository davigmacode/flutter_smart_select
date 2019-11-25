import 'package:flutter/material.dart';
import '../utils.dart';

class SmartMultiSelectTarget extends StatefulWidget {

  final String title;
  final dynamic value;
  final List<Map<String,dynamic>> options;
  final bool searchable;
  final SmartSelectTarget target;

  SmartMultiSelectTarget({
    Key key,
    this.title,
    this.value,
    this.options,
    this.searchable,
    this.target = SmartSelectTarget.page,
  }) : super(key: key);

  SmartMultiSelectTarget.popup({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : this.target = SmartSelectTarget.popup,
      this.searchable = false,
      super(key: key);

  SmartMultiSelectTarget.sheet({
    Key key,
    this.title,
    this.value,
    this.options,
  }) : this.target = SmartSelectTarget.sheet,
      this.searchable = false,
      super(key: key);

  @override
  _SmartMultiSelectTargetState createState() => _SmartMultiSelectTargetState();
}

class _SmartMultiSelectTargetState extends State<SmartMultiSelectTarget> {

  List _selectedList = [];

  @override
  void initState() {
    // initial load value
    _selectedList = List.from(widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.target) {
      case SmartSelectTarget.page:
        return _modePageBuilder(context);
        break;
      case SmartSelectTarget.sheet:
        return _modeSheetBuilder(context);
        break;
      case SmartSelectTarget.popup:
        return _modePopupBuilder(context);
        break;
    }
  }

  Widget _modePageBuilder (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            tooltip: 'Done',
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.pop(context, _selectedList),
          ),
        ],
      ),
      body: Container(
        child: _checkboxesBuilder(context),
      ),
    );
  }

  Widget _modePopupBuilder (BuildContext context) {
    return Dialog(
      child: _checkboxesBuilder(context),
    );
  }

  Widget _modeSheetBuilder (BuildContext context) {
    return _checkboxesBuilder(context);
  }

  Widget _checkboxesBuilder (BuildContext context) {
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
            onChanged: (_value) {
              setState(() {
                if (_value) {
                  _selectedList.add(item['value']);
                } else {
                  _selectedList.remove(item['value']);
                }
              });
            }
          );
        }
      ),
    );
  }
}