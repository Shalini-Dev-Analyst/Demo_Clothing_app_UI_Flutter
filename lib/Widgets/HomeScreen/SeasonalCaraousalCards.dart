import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Seasonalcaraousalcards extends StatefulWidget {
  final List<Map<String, dynamic>> banners;

  const Seasonalcaraousalcards({super.key, required this.banners});

  @override
  State<Seasonalcaraousalcards> createState() => _SeasonalcaraousalcardsState();
}

class _SeasonalcaraousalcardsState extends State<Seasonalcaraousalcards> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_controller.hasClients && widget.banners.isNotEmpty) {
          int next = _controller.page!.round() + 1;
          if (next == widget.banners.length) next = 0;

          _controller.animateToPage(
            next,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * 0.5,
      width: w,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.banners.length,
        itemBuilder: (context, index) {
          final img = widget.banners[index]["img"];
          final text1 = widget.banners[index]["text1"] ?? "";
          final text2 = widget.banners[index]["text2"] ?? "";

          return Stack(
            alignment: Alignment.center,
            children: [
              // Banner Image
              Stack(
                children: [
                  // IMAGE
                  Positioned.fill(
                      child: Image.asset(img, fit: BoxFit.cover)),

                  // TOP SHADOW OVERLAY
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: h * 0.15, // adjust fade height
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  // BOTTOM SHADOW OVERLAY
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: h * 0.2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.blue.withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // // Overlay Frame (always fits perfectly)
              // Positioned.fill(
              //   child: Image.asset(
              //     "assets/bgs/gold-removebg-preview.png",
              //     fit: BoxFit.fill,
              //   ),
              // ),

              // Text Overlay
              Positioned(
                bottom: 30,
                left: 60,
                right: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: h * 0.025,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      text2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: h * 0.025,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
