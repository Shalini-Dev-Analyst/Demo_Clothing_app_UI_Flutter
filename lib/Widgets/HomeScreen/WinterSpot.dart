import 'dart:async';

import 'package:flutter/material.dart';

class Winterspot extends StatefulWidget {
  final List<Map<String, dynamic>> season;
  const Winterspot({super.key, required this.season});

  @override
  State<Winterspot> createState() => _WinterspotState();
}

class _WinterspotState extends State<Winterspot> {
  late PageController _controller;
  double currentPage = 0.0;
  late Timer _autoScrollTimer;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      viewportFraction: 0.45,
    );

    // Listen to active page for scale animation
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!;
      });
    });

    // AUTO SCROLL every 4 seconds
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_controller.hasClients) {
        int nextPage = _controller.page!.round() + 1;

        if (nextPage == widget.season.length) {
          nextPage = 0; // go back to first image
        }

        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * 0.3,
      width: w,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.season.length,
        itemBuilder: (context, index) {
          final img = widget.season[index]["img"] ?? "";

          double scale = (1 - (currentPage - index).abs()).clamp(0.7, 1.0);

          return Transform.scale(
            scale: scale,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

