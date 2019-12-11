import 'package:flutter/material.dart';

class FeaturesHeader extends StatelessWidget {

  final String title;

  FeaturesHeader(this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      color: Colors.blueGrey[50],
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.body2.merge(TextStyle(color: Colors.black54)),
      ),
    );
  }
}