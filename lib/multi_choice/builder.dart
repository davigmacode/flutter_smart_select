import 'package:flutter/material.dart';
import '../utils.dart';

typedef Widget SmartMultiSelectBuilder(
    BuildContext context, SmartMultiSelectBuilderInfo info);

class SmartMultiSelectBuilderInfo {
  final String title;
  final String placeholder;
  final dynamic selected;
  final Function showOptions;
  final SmartSelectTarget target;

  SmartMultiSelectBuilderInfo({
    this.title,
    this.placeholder,
    this.selected,
    this.showOptions,
    this.target,
  });

  List get selectedLabel {
    return selected != null ? selected.map((x) => x['label']).toList() : null;
  }

  List get selectedValue {
    return selected != null ? selected.map((x) => x['label']).toList() : null;
  }

  String get values {
    return selected != null && selected.length > 0 ? selectedLabel.join(', ') : placeholder;
  }
}

class SmartMultiSelectBuilderDefault extends StatelessWidget {
  final SmartMultiSelectBuilderInfo info;

  SmartMultiSelectBuilderDefault({Key key, this.info}) : super(key: key);

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
                info.values,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            ),
          ],
        ),
      ),
      onTap: () => info.showOptions(context),
    );
  }
}
