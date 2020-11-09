import 'package:flutter/material.dart';

class FeaturesHeader extends StatelessWidget {

  final String title;

  const FeaturesHeader(this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(title),
    );
  }
}