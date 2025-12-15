import 'package:flutter/material.dart';

class StaggeredSlideIn extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDuration;
  final Duration itemDelay;
  final Offset beginOffset; // animation direction

  const StaggeredSlideIn({
    super.key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 500),
    this.itemDelay = const Duration(milliseconds: 120),
    this.beginOffset = const Offset(0.3, 0), // slide from right
  });

  @override
  _StaggeredSlideInState createState() => _StaggeredSlideInState();
}

class _StaggeredSlideInState extends State<StaggeredSlideIn>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _offsetAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      widget.children.length,
          (_) => AnimationController(
        vsync: this,
        duration: widget.itemDuration,
      ),
    );

    _offsetAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: widget.beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    _playAnimations();
  }

  /// Plays animations with delay between each widget
  Future<void> _playAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(widget.itemDelay);
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (index) {
        return AnimatedBuilder(
          animation: _controllers[index],
          builder: (_, child) {
            return Opacity(
              opacity: _fadeAnimations[index].value,
              child: Transform.translate(
                offset: _offsetAnimations[index].value * 100,
                child: child,
              ),
            );
          },
          child: widget.children[index],
        );
      }),
    );
  }
}
