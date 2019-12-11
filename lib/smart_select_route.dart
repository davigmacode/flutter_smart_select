import 'package:flutter/material.dart';
import './smart_select_route_header.dart';
import './smart_select_option.dart';
import './smart_select_choices.dart';
import './smart_select_state.dart';

class SmartSelectRoute extends StatefulWidget {

  final String title;
  final dynamic value;
  final SmartSelectOption option;
  final SmartSelectTarget target;

  SmartSelectRoute({
    Key key,
    @required this.title,
    @required this.value,
    @required this.option,
    this.target = SmartSelectTarget.page,
  }) : super(key: key);

  @override
  SmartSelectRouteState createState() => SmartSelectRouteState();
}

class SmartSelectRouteState extends State<SmartSelectRoute> {

  final GlobalKey<SmartSelectChoicesState> choicesCtrl =
      GlobalKey<SmartSelectChoicesState>();

  bool _isFiltering = false;
  String _filterQuery;

  @override
  Widget build(BuildContext context) {
    if (widget.target == SmartSelectTarget.page) {
      return Scaffold(
        appBar: _routeHeader,
        backgroundColor: widget.option.backgroundColor,
        body: Container(
          child: _choicesWidget,
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _routeHeader,
          Flexible(
            fit: FlexFit.loose,
            child: _choicesWidget,
          )
        ].where((child) => child != null).toList(),
      );
    }
  }

  Widget get _routeHeader {
    return widget.option.useHeader
      ? RouteHeader(
          title: widget.title,
          target: widget.target,
          filterable: widget.option.useFilter,
          confirmButton: _confirmWidget,
          theme: widget.option.headerTheme,
          onFilterStatus: (val) => setState(() => _isFiltering = val),
          onFilterQuery: (val) => setState(() => _filterQuery = val),
        )
      : null;
  }

  Widget get _confirmWidget {
    return widget.option.useConfirmation
      ? widget.option.confirmationBuilder != null
        ? widget.option.confirmationBuilder(context, () => Navigator.pop(context, true))
        : IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: () => Navigator.pop(context, true),
          )
      : null;
  }

  Widget get _choicesWidget {
    return SmartSelectChoices(
      key: choicesCtrl,
      value: widget.value,
      option: widget.option,
      isFiltering: _isFiltering,
      filterQuery: _filterQuery,
    );
  }
}