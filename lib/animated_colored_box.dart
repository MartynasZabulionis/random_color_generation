import 'package:flutter/material.dart';

/// Efficient widget that animates color change
class AnimatedColoredBox extends StatefulWidget {
  /// A color to animate to
  final Color color;

  /// The default constructor that takes color as argument
  const AnimatedColoredBox({
    super.key,
    required this.color,
  });

  @override
  State<AnimatedColoredBox> createState() => _AnimatedColoredBoxState();
}

class _AnimatedColoredBoxState extends State<AnimatedColoredBox>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this)
    ..addListener(() {
      // ignore: no-empty-block
      setState(() {});
    });
  late var _colorTween = ColorTween(begin: widget.color, end: widget.color);

  // ignore: avoid-non-null-assertion
  Color get _currentColor => _colorTween.lerp(_controller.value)!;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _currentColor,
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedColoredBox oldWidget) {
    if (oldWidget.color != widget.color) {
      _colorTween = ColorTween(begin: _currentColor, end: widget.color);
      _controller
        ..reset()
        ..animateTo(
          _controller.upperBound,
          duration: const Duration(milliseconds: 300),
        );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
