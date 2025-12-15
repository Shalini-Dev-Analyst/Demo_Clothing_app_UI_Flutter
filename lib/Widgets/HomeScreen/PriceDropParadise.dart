import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Constants/app_fonts.dart';

class Pricedropparadise extends StatefulWidget {
  final List<Map<String, dynamic>> Brands;
  const Pricedropparadise({super.key,required this.Brands});

  @override
  State<Pricedropparadise> createState() => _PricedropparadiseState();
}

class _PricedropparadiseState extends State<Pricedropparadise> {
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

        if (nextPage == widget.Brands.length) {
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
      height: h * 0.4,
      width: w*1,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.Brands.length,
        itemBuilder: (context, index) {
          final img = widget.Brands[index]["img"] ?? "";
          final offer = widget.Brands[index]["text"] ?? "";
          double scale = (1 - (currentPage - index).abs()).clamp(0.9, 1.0);

          return Transform.scale(
            scale: scale,
            child: Container(
              width: w * 0.4,
              height: h * 0.18,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Smaller Background Image
                  Positioned(
                    top: h * 0.02,
                    left: w * 0.057,
                    right: w * 0.07,
                    bottom: h * 0.018,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10)),
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  // OFFER BADGE
                  Positioned(
                    bottom: h *0.01,
                    left: w * 0.059,
                    right: w * 0.07,
                    child: Container(
                      height: h * 0.04,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(0),
                        color:Colors.white,
                        // image: DecorationImage(
                        //   image: AssetImage("assets/bgs/ofeerends.jpg"),
                        //   fit: BoxFit.cover,
                        //   colorFilter: ColorFilter.mode(
                        //     Colors.black.withOpacity(0.2),
                        //     BlendMode.darken,
                        //   ),
                        // ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        offer,
                        style: GoogleFonts.getFont(
                          AppFonts.contents,
                          fontWeight: FontWeight.w400,
                          fontSize: h * 0.016,
                          color: Colors.black,
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
