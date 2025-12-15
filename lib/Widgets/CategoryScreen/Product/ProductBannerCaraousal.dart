import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Productbannercaraousal extends StatefulWidget {
  final List<Map<String, dynamic>> productbanners;
  const Productbannercaraousal({super.key,required this.productbanners});

  @override
  State<Productbannercaraousal> createState() => _ProductbannercaraousalState();
}

class _ProductbannercaraousalState extends State<Productbannercaraousal> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    //AUTO SLIDER
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_controller.hasClients && widget.productbanners.isNotEmpty) {
          int next = _controller.page!.round() + 1;
          if (next == widget.productbanners.length) next = 0;

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
          height: h * 0.2,
          width: w*1,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.productbanners.length,
            itemBuilder: (context, index) {
              final img = widget.productbanners[index]["img"] ?? "";

              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),

        SizedBox(height: h * 0.005),

        SmoothPageIndicator(
          controller: _controller,
          count: widget.productbanners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 5,
            dotWidth: 5,
            expansionFactor: 1.1,
            activeDotColor: Color(0XFFE3263A),
            dotColor: Color(0XFF00458C),
          ),
        ),
      ],
    );
  }
}
