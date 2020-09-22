// import 'package:flutter/widgets.dart';
// import './model/builder.dart';
// import './model/choice_item.dart';
// import './model/choice_config.dart';
// import './state/choices.dart';
// import './choices_grouped.dart';
// import './choices_list.dart';
// import './choices_empty.dart';
// import './spinner.dart';

// class S2ChoicesWrapper<T> extends StatefulWidget {

//   final Widget Function(S2Choice<T>) itemBuilder;
//   final S2Choices<T> choices;
//   final S2ChoiceConfig config;
//   final S2Builder<T> builder;
//   final String query;

//   S2ChoicesWrapper({
//     Key key,
//     @required this.itemBuilder,
//     @required this.choices,
//     @required this.config,
//     @required this.builder,
//     @required this.query,
//   }) : super(key: key);

//   @override
//   _S2ChoicesWrapperState<T> createState() => _S2ChoicesWrapperState<T>();
// }

// class _S2ChoicesWrapperState<T> extends State<S2ChoicesWrapper<T>> {

//   // changes listener handler
//   void _choicesHandler() => setState(() {});

//   @override
//   void initState() {
//     super.initState();
//     widget.choices..addListener(_choicesHandler);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.choices.refresh(
//         query: widget.query,
//         init: true,
//       );
//     });
//   }

//   @override
//   void didUpdateWidget(S2ChoicesWrapper<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.query != oldWidget.query) {
//       widget.choices.refresh(
//         query: widget.query,
//         init: true,
//       );
//     }
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   @override
//   void dispose() {
//     widget.choices..removeListener(_choicesHandler);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.choices.initializing) {
//       return choiceLoading;
//     }
//     if (widget.choices.items != null && (widget.choices.items?.isNotEmpty ?? false)) {
//       return widget.choices.groups.isNotEmpty
//         ? S2ChoicesGrouped<T>(
//             groupKeys: widget.choices.groups,
//             items: widget.choices.items,
//             itemBuilder: widget.itemBuilder,
//             config: widget.config,
//             builder: widget.builder,
//             query: widget.query,
//           )
//         : S2ChoicesList<T>(
//             items: widget.choices.items,
//             itemBuilder: widget.itemBuilder,
//             config: widget.config,
//             builder: widget.builder,
//           );
//     } else {
//       return choiceEmpty;
//     }
//   }

//   Widget get choiceLoading {
//     return widget.builder?.choiceProgressBuilder?.call(context) ?? defaultChoiceLoading;
//   }

//   Widget get defaultChoiceLoading {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget get choiceEmpty {
//     return widget.builder?.choiceEmptyBuilder?.call(context, widget.query) ?? defaultChoiceEmpty;
//   }

//   Widget get defaultChoiceEmpty {
//     return const S2ChoicesEmpty();
//   }
// }
