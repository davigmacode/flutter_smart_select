import 'package:flutter/widgets.dart';

/// Default widget for empty choices list
class S2ChoicesEmpty extends StatelessWidget {

  /// default constructor
  const S2ChoicesEmpty();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              const IconData(0xe8b6, fontFamily: 'MaterialIcons'),
              color: Color(0x1F000000),
              size: 120.0,
            ),
            Container(height: 25),
            Text(
              'Whoops, no matches',
              style: TextStyle(color: Color(0x8A000000)),
            ),
            Container(height: 7),
            Text(
              "We couldn't find any search result",
              style: TextStyle(color: Color(0x8A000000)),
            ),
            Container(height: 7),
            Text(
              "Give it another go",
              style: TextStyle(color: Color(0x8A000000)),
            )
          ],
        ),
      ),
    );
  }
}
