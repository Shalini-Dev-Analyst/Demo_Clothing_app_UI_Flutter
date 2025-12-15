import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> banners;

  const BannerCarousel({
    super.key,
    required this.banners,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    //AUTO SLIDER
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_controller.hasClients && widget.banners.isNotEmpty) {
          int next = _controller.page!.round() + 1;
          if (next == widget.banners.length) next = 0;

          _controller.animateToPage(
            next,
            duration: const Duration(milliseconds: 350),
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

    return Column(
      children: [
        SizedBox(
          height: h * 0.25,
          width: w*1,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              final img = widget.banners[index]["img"] ?? "";

              return Image.asset(
                img,
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        SizedBox(height: h * 0.005),

        SmoothPageIndicator(
          controller: _controller,
          count: widget.banners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 5,
            dotWidth: 40,
            expansionFactor: 1.1,
            activeDotColor: Color(0XFFE3263A),
            dotColor: Color(0XFF00458C),
          ),
        ),
      ],
    );
  }
}

