import 'package:flutter/material.dart';

/// Controller for [S2TextError]
class S2TextErrorController extends ChangeNotifier {
  /// Default constructor
  S2TextErrorController({
    bool? visibled,
  }) : _visibled = visibled ?? false;

  bool? _visibled;

  bool? _shaked;

  /// Returns `true` if the text error widget is visibled
  bool? get visibled => _visibled;

  /// Returns `true` if the text error widget is shaked
  bool get shaked => _shaked ?? false;

  /// Set the [visibled] by provided value
  void visibility(bool? value) {
    _visibled = value;
    notifyListeners();
  }

  /// Set the [visibled] to `true`
  void show() {
    visibility(true);
  }

  /// Set the [visibled] to `false`
  void hide() {
    visibility(false);
  }

  /// Set the [shaked] by provided value
  void shake([bool value = true]) {
    _shaked = value;
    notifyListeners();
  }
}

/// Widget that show/hide/shake error text
class S2TextError extends StatefulWidget {
  /// Primary child widget
  final Widget? child;

  /// Whether the widget is visible or not
  final bool? visibled;

  /// Listenable that control the flow of [S2TextError] widget
  final S2TextErrorController? controller;

  /// Default constructor
  S2TextError({
    Key? key,
    this.child,
    this.visibled,
    this.controller,
  }) : super(key: key);

  @override
  _S2TextErrorState createState() => _S2TextErrorState();
}

class _S2TextErrorState extends State<S2TextError> {
  /// Listenable that control the flow of [S2TextError] widget
  S2TextErrorController? controller;

  /// Returns the default controller
  S2TextErrorController get defaultController {
    return S2TextErrorController(visibled: widget.visibled);
  }

  /// Set the [controller] by provider value
  void initController(newController) {
    controller?.dispose();
    controller = (newController ?? defaultController)
      ..addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(S2TextError oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      initController(widget.controller);
    }

    if (oldWidget.visibled != widget.visibled) {
      controller!.visibility(widget.visibled);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initController(widget.controller);
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(height: 0.0, width: 0.0),
      secondChild: controller?.shaked == true ? shakedChild : widget.child!,
      duration: const Duration(milliseconds: 300),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: controller?.visibled == true
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
    );
  }

  /// Returns the shaked child widget
  Widget get shakedChild {
    return TweenAnimationBuilder<double>(
      child: widget.child,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      onEnd: () {
        controller!.shake(false);
      },
      builder: (context, animation, child) {
        final Curve curve = Curves.elasticOut;
        final double delta = 15;
        final double pos = 2 * (0.5 - (0.5 - curve.transform(animation)).abs());
        return Transform.translate(
          offset: Offset(delta * pos, 0),
          child: child,
        );
      },
    );
  }
}
