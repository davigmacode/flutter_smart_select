import 'package:flutter/material.dart';

// class StateProvider<T extends ChangeNotifier> extends InheritedNotifier<ChangeNotifier> {
//   const StateProvider({
//     Key key,
//     Widget child,
//     T notifier,
//   }) : super(
//     key: key,
//     child: child,
//     notifier: notifier
//   );

//   static T of<T extends ChangeNotifier>(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<StateProvider<T>>();
//   }
// }

class StateProvider<T> extends InheritedWidget {
  final T state;

  StateProvider({
    Key key,
    @required this.state,
    @required Widget child
  }) : assert(child != null),
    super(key: key, child: child);

  static T of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateProvider<T>>().state;
  }

  @override
  bool updateShouldNotify(StateProvider<T> old) => state != old.state;
}

class StateConsumer<T> extends StatelessWidget {

  final Widget Function(BuildContext context, T state, Widget child) builder;
  final Widget child;

  StateConsumer({
    Key key,
    @required this.builder,
    this.child,
  }) : assert(builder != null),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      StateProvider.of<T>(context),
      child,
    );
  }
}