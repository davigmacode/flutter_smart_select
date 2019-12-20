import 'package:flutter/material.dart';

class SmartSelectChoicesEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}