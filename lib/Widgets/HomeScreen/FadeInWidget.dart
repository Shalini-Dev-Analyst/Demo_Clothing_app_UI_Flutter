import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetY;

  const FadeInOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.offsetY = 30,
  });

  @override
  _FadeInOnScrollState createState() => _FadeInOnScrollState();
}

class _FadeInOnScrollState extends State<FadeInOnScroll> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          duration: widget.duration,
          curve: Curves.easeOut,
          offset: _visible ? Offset.zero : Offset(0, 0.2),
          child: widget.child,
        ),
      ),
    );
  }
}
