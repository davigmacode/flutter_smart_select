import 'package:flutter/material.dart';
import '../utils.dart';

typedef Widget SmartSelectBuilder(BuildContext context, SmartSelectBuilderInfo info);

class SmartSelectBuilderInfo {

  final String title;
  final String placeholder;
  final dynamic selected;
  final Function showOptions;
  final SmartSelectTarget target;

  SmartSelectBuilderInfo({
    this.title,
    this.placeholder,
    this.selected,
    this.showOptions,
    this.target,
  });

  String get selectedLabel {
    return selected != null ? selected['label'] : null;
  }

  String get selectedValue {
    return selected != null ? selected['value'] : null;
  }
}

class SmartSelectBuilderDefault extends StatelessWidget {
  final SmartSelectBuilderInfo info;

  SmartSelectBuilderDefault({
    Key key,
    this.info
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(info.title),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: 100),
              child: Text(
                info.selectedLabel ?? info.placeholder,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
      onTap: () => info.showOptions(context),
    );
  }
}