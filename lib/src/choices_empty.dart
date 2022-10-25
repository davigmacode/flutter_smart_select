import 'package:flutter/material.dart';

/// Default widget for empty choices list
class S2ChoicesEmpty extends StatelessWidget {
  /// Default constructor
  const S2ChoicesEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 120.0,
          ),
          SizedBox(height: 25),
          Text(
            'Whoops, no matches',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 7),
          Text(
            "We couldn't find any search result",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 7),
          Text(
            "Give it another go",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
