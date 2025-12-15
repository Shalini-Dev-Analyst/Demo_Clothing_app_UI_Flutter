import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Curatedeclusives extends StatefulWidget {
  final List<Map<String, dynamic>> Exclusives;
  const Curatedeclusives({super.key,required this.Exclusives});

  @override
  State<Curatedeclusives> createState() => _CuratedeclusivesState();
}

class _CuratedeclusivesState extends State<Curatedeclusives> {
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
        itemCount: widget.Exclusives.length,

        itemBuilder: (context, index) {
          final img = widget.Exclusives[index]["img"];
          final text = widget.Exclusives[index]["text"] ?? "";

          return Container(
            margin: EdgeInsets.only(
              right: w * 0.015,
              left: w * 0.015,
              bottom: h * 0.03,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                //BLUE BACKGROUND WITH GLOW
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60),
                      ),
                      border:Border.all(color:Colors.grey.shade300),
                      color: Colors.white.withOpacity(0.2),

                      //GLOW EFFECT
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,     // glow size
                          spreadRadius: 5,
                          offset: Offset(3, 25),
                        ),
                      ],
                    ),
                  ),
                ),

                //ENLARGED IMAGE
                Positioned(
                  top: -h * 0.0,   // reduced padding
                  left: w * 0.02,
                  right: w * 0.02,
                  bottom: h * 0.0,
                  child: Image.asset(
                    img,
                    fit: BoxFit.contain,
                    height: h * 0.6,
                  ),
                ),

                // OFFER BADGE
                Positioned(
                  bottom: -h * 0.005,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: h * 0.025,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage("assets/bgs/3a114ea5aab334ab577a6d04f4dd64bc.jpg"),
                      //   fit: BoxFit.cover,
                      //   // colorFilter: ColorFilter.mode(
                      //   //   Colors.white.withOpacity(0.1),
                      //   //   BlendMode.darken,
                      //   // ),
                      // ),
                      color:Color(0XFFF9F9F9),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w900,
                        fontSize: h * 0.012,
                        color:Color(0XFF9C0005),
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
