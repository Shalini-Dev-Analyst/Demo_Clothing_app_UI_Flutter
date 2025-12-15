import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';

class Brandsoffercard extends StatelessWidget {
  final String img;

  const Brandsoffercard({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        right: w * 0.04,
        top: h * 0.01,
        bottom: h * 0.03,
      ),
      width: w * 0.49,
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
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Frame Overlay (fills the card)
          Positioned.fill(
            child: Image.asset(
              "assets/bgs/offer_box-removebg-preview.png",
              fit: BoxFit.fill,
            ),
          ),

          // OFFER BADGE
          Positioned(
            bottom: -h * 0,
            left: w * 0.07,
            right: w * 0.085,
            child: Container(
              height: h * 0.03,
              decoration: BoxDecoration(
                color:Color(0XFFd93932),
                // image: DecorationImage(
                //   image: AssetImage("assets/bgs/offerend.jpg"),
                //   fit: BoxFit.cover,
                //   colorFilter: ColorFilter.mode(
                //     Colors.black.withOpacity(0.2),
                //     BlendMode.darken,
                //   ),
                // ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Min 10 OFF",
                style: GoogleFonts.getFont(
                  AppFonts.contents,
                  fontWeight: FontWeight.w500,
                  fontSize: h * 0.016,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
