import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Constants/app_fonts.dart';

class Todaystopsteals extends StatefulWidget {
  final List<Map<String, dynamic>> TopProducts;

  const Todaystopsteals({super.key, required this.TopProducts});

  @override
  State<Todaystopsteals> createState() => _TodaystopstealsState();
}

class _TodaystopstealsState extends State<Todaystopsteals> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * 0.3,
      width: w,

      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,       // 2 per row
          childAspectRatio: 0.8,   // Adjust height ratio
        ),
        itemCount: widget.TopProducts.length,

        itemBuilder: (context, index) {
          final img = widget.TopProducts[index]["img"];
          final text = widget.TopProducts[index]["text"] ?? "";

          return Container(
            margin: EdgeInsets.only(
              right: w * 0.015,
              left:w*0.015,
              bottom: h * 0.03,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Frame Overlay
                Positioned.fill(
                  child: Opacity(
                    opacity:1,
                    child: Image.asset(
                      "assets/bgs/pinkgold.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                  bottom: -h * 0.01,
                  left: w * 0,
                  right: w * 0,
                  child: Container(
                    height: h * 0.025,
                    decoration: BoxDecoration(
                      color: Color(0XFF124D86)
                      // image: DecorationImage(
                      //   image: AssetImage("assets/bgs/download.png"),
                      //   fit: BoxFit.cover,
                      //   colorFilter: ColorFilter.mode(
                      //     Colors.blue.withOpacity(0.5),
                      //     BlendMode.darken,
                      //   ),
                      // ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: GoogleFonts.getFont(
                        AppFonts.contents,
                        fontWeight: FontWeight.w500,
                        fontSize: h * 0.014,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
