import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Elitespotlight extends StatefulWidget {
  final List<Map<String, dynamic>> Elite;
  const Elitespotlight({super.key,required this.Elite});

  @override
  State<Elitespotlight> createState() => _ElitespotlightState();
}

class _ElitespotlightState extends State<Elitespotlight> {
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

        if (nextPage == widget.Elite.length) {
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
      width: w*1,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.Elite.length,
        itemBuilder: (context, index) {
          final img = widget.Elite[index]["img"] ?? "";
          final offer = widget.Elite[index]["text"] ?? "";
          double scale = (1 - (currentPage - index).abs()).clamp(0.7, 1.0);

          return Transform.scale(
            scale: scale,
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(
                right: w * 0.015,
                left:w*0.015,
                bottom: h * 0.04,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // // Frame Overlay
                  // Positioned.fill(
                  //   child: Image.asset(
                  //     "assets/bgs/blackgold.jpg",
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  // Smaller Background Image
                  Positioned(
                    top: h * 0.015,
                    left: w * 0.04,
                    right: w * 0.04,
                    bottom: h * 0.01,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        img,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // OFFER BADGE
                  Positioned(
                    bottom: h * 0.009,
                    left: w * 0.04,
                    right: w * 0.04,
                    child: Container(
                      height: h * 0.025,
                      decoration: BoxDecoration(
                          color:Colors.black.withOpacity(0.4)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        offer,
                        style: GoogleFonts.gfsDidot(
                          fontWeight: FontWeight.w900,
                          fontSize: h * 0.014,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
