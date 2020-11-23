import 'package:flutter/widgets.dart';

/// The same as [StatefulBuilder] but enhanced with prevent error when calling setState after disposed
class S2StatefulBuilder extends StatefulWidget {
  /// Creates a widget that both has state and delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const S2StatefulBuilder({
    Key key,
    @required this.builder,
  }) : assert(builder != null),
       super(key: key);

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final StatefulWidgetBuilder builder;

  @override
  _S2StatefulBuilderState createState() => _S2StatefulBuilderState();
}

class _S2StatefulBuilderState extends State<S2StatefulBuilder> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}