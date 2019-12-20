import 'package:flutter/material.dart';
import './model/modal_config.dart';
import './modal_header.dart';

class SmartSelectModal extends StatelessWidget {

  final String title;
  final SmartSelectModalConfig config;
  final Widget choices;

  SmartSelectModal({
    Key key,
    @required this.title,
    @required this.config,
    @required this.choices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (config.type == SmartSelectModalType.fullPage) {
      return Scaffold(
        backgroundColor: config.style.backgroundColor,
        appBar: _routeHeader,
        body: _routeBody,
      );
    } else {
      return _routeBody;
    }
  }

  bool get _isFullPage {
    return config.type == SmartSelectModalType.fullPage;
  }

  Widget get _routeHeader {
    return config.useHeader
      ? SmartSelectModalHeader(
          title: config?.title ?? title,
          config: config,
        )
      : null;
  }

  Widget get _routeBody {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _isFullPage != true ? _routeHeader : null,
          config.leading,
          Flexible(
            fit: FlexFit.loose,
            child: choices,
          ),
          config.trailing,
        ].where((child) => child != null).toList(),
      )
    );
  }
}