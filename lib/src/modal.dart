import 'package:flutter/widgets.dart';

/// The same as [StatefulBuilder] but enhanced with prevent error when calling setState after disposed
class S2Modal extends StatefulWidget {
  /// Creates a widget that both has state and delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const S2Modal({
    Key? key,
    required this.builder,
    required this.onReady,
  }) : super(key: key);

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final StatefulWidgetBuilder builder;

  /// Called when modal is rendered completely
  final VoidCallback onReady;

  @override
  S2ModalState createState() => S2ModalState();
}

class S2ModalState extends State<S2Modal> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onReady.call());
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}
