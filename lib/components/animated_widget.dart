import 'package:flutter/material.dart';

class ScaleAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  const ScaleAnimatedSwitcher({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 0),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class EmptyAnimatedSwitcher extends StatelessWidget {
  final bool display;
  final Widget child;

  const EmptyAnimatedSwitcher(
      {Key? key, this.display = true, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitcher(
        child: display ? child : const SizedBox.shrink());
  }
}
