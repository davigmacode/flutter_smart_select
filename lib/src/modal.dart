import 'package:flutter/material.dart';
import 'model/modal_theme.dart';
import 'model/modal_config.dart';

class S2Modal extends StatelessWidget {

  final S2ModalConfig config;
  final Widget header;
  final Widget choices;
  final Widget divider;
  final Widget footer;

  S2Modal({
    Key key,
    @required this.config,
    @required this.header,
    @required this.choices,
    @required this.divider,
    @required this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_isFullPage == true) {
      return Scaffold(
        backgroundColor: config.style.backgroundColor,
        appBar: PreferredSize(
          child: header,
          preferredSize: Size.fromHeight(kToolbarHeight)
        ),
        body: _modalBody,
      );
    } else {
      return _modalBody;
    }
  }

  bool get _isFullPage {
    return config.type == S2ModalType.fullPage;
  }

  Widget get _modalBody {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _isFullPage != true ? header : null,
          divider,
          Flexible(
            fit: FlexFit.loose,
            child: choices,
          ),
          divider,
          footer,
        ]..removeWhere((child) => child == null),
      ),
    );
  }
}

class S2ModalHeader extends StatelessWidget {

  final Widget title;
  final Widget filterToggle;
  final Widget confirmButton;
  final S2ModalHeaderStyle style;
  final bool useLeading;

  S2ModalHeader({
    Key key,
    @required this.title,
    @required this.filterToggle,
    @required this.confirmButton,
    @required this.style,
    @required this.useLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: style.shape,
      elevation: style.elevation,
      brightness: style.brightness,
      backgroundColor: style.backgroundColor,
      actionsIconTheme: style.actionsIconTheme,
      iconTheme: style.iconTheme,
      centerTitle: style.centerTitle,
      automaticallyImplyLeading: useLeading,
      title: title,
      actions: <Widget>[
        filterToggle,
        confirmButton,
      ]..removeWhere((child) => child == null),
    );
  }
}
