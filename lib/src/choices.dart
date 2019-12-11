import 'package:flutter/material.dart';
import './option.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SmartSelectChoices extends StatefulWidget {
  final dynamic value;
  final SmartSelectOption option;
  final bool isFiltering;
  final String filterQuery;

  SmartSelectChoices({
    Key key,
    @required this.value,
    @required this.option,
    this.isFiltering = false,
    this.filterQuery,
  }) : super(key: key);

  @override
  SmartSelectChoicesState createState() => SmartSelectChoicesState();
}

class SmartSelectChoicesState extends State<SmartSelectChoices> {
  dynamic _selected;

  @override
  void initState() {
    super.initState();

    // initial load value
    _selected =
        widget.option.isMultiChoice ? List.from(widget.value) : widget.value;
  }

  dynamic get selected => _selected;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.symmetric(
          horizontal: widget.option.isMultiChoice ? 25.0 : 10),
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: widget.option.itemTheme.unselectedColor,
        ),
        child: Scrollbar(
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: widget.option.glowingOverscrollIndicatorColor,
              child: _listBuilder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listBuilder() {
    List _options = widget.option.filteredList(widget.filterQuery);
    return _options.length > 0
        ? widget.option.groupBy != null
            ? _listGroupedBuilder(widget.option.groupKeys(_options), _options)
            : _listDefaultBuilder(_options)
        : _listEmpty();
  }

  Widget _listEmpty() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search, size: 120.0, color: Colors.black12),
            Container(height: 25),
            Text(
              'Whoops, no matches',
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .merge(TextStyle(color: Colors.black54)),
            ),
            Container(height: 7),
            Text(
              "We couldn't find any search result",
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .merge(TextStyle(color: Colors.black45)),
            ),
            Container(height: 7),
            Text(
              "Give it another go",
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .merge(TextStyle(color: Colors.black45)),
            )
          ],
        ),
      ),
    );
  }

  Widget _listDefaultBuilder(List _items) {
    return widget.option.useDivider
        ? _listSeparatedBuilder(_items)
        : _listSimpleBuilder(_items);
  }

  Widget _listSimpleBuilder(List _items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: _items.length,
      itemBuilder: _itemBuilder(_items),
    );
  }

  Widget _listSeparatedBuilder(List _items) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: _items.length,
      itemBuilder: _itemBuilder(_items),
      separatorBuilder: widget.option.dividerBuilder ?? _dividerBuilder,
    );
  }

  Widget _listGroupedBuilder(List _keys, List _items) {
    return ListView.builder(
      itemCount: _keys.length,
      itemBuilder: (BuildContext context, int i) {
        String _groupKey = _keys[i].toString();
        List _groupItems = widget.option.groupItems(_items, _groupKey);
        return StickyHeader(
          content: _listDefaultBuilder(_groupItems),
          header: widget.option.groupHeaderBuilder != null
              ? widget.option.groupHeaderBuilder(_groupKey, _groupItems.length)
              : _listGroupedHeaderBuilder(_groupKey, _groupItems.length),
        );
      },
    );
  }

  Widget _listGroupedHeaderBuilder(String _group, int _count) {
    return Container(
      height: widget.option.groupHeaderTheme.height,
      color: widget.option.groupHeaderTheme.backgroundColor,
      padding: widget.option.groupHeaderTheme.padding,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _group,
            style: Theme.of(context)
                .textTheme
                .body2
                .merge(widget.option.groupHeaderTheme.titleStyle),
          ),
          Text(
            _count.toString(),
            style: Theme.of(context)
                .textTheme
                .body2
                .merge(widget.option.groupHeaderTheme.titleStyle),
          ),
        ],
      ),
    );
  }

  Widget _dividerBuilder(BuildContext context, int index) {
    return Divider();
  }

  IndexedWidgetBuilder _itemBuilder(List _items) {
    return (BuildContext context, int i) {
      Map<String, dynamic> _item = _items[i];
      String _label = _item[widget.option.label];
      var _value = _item[widget.option.value];
      bool _checked = _selected.contains(_value);

      return widget.option.itemBuilder != null
          ? widget.option.itemBuilder(_item, _checked, _itemOnChange)
          : widget.option.isMultiChoice
              ? _checkboxBuilder(_label, _value)
              : _radioBuilder(_label, _value);
    };
  }

  Widget _radioBuilder(String label, dynamic value) {
    return RadioListTile(
      title: Text(
        label,
        style: widget.option.itemTheme.titleStyle,
      ),
      value: value,
      groupValue: _selected,
      activeColor: widget.option.itemTheme.activeColor,
      onChanged: (val) => _itemOnChange(val, true),
    );
  }

  Widget _checkboxBuilder(String label, dynamic value) {
    return CheckboxListTile(
      title: Text(
        label,
        style: widget.option.itemTheme.titleStyle,
      ),
      value: _selected.contains(value),
      checkColor: widget.option.itemTheme.checkColor,
      activeColor: widget.option.itemTheme.activeColor,
      onChanged: (checked) => _itemOnChange(value, checked),
    );
  }

  void _itemOnChange(dynamic value, bool checked) {
    if (widget.option.isMultiChoice) {
      setState(() {
        if (checked) {
          _selected.add(value);
        } else {
          _selected.remove(value);
        }
      });
    } else {
      setState(() => _selected = value);

      // Pop filtering status
      if (widget.isFiltering) {
        Navigator.pop(context);
      }

      // Pop navigator with confirmed return value
      if (!widget.option.useConfirmation) {
        Navigator.pop(context, true);
      }
    }
  }
}
