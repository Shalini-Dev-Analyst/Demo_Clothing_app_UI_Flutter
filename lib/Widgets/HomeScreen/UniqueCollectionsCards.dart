import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Uniquecollectionscards extends StatefulWidget {
  final List<Map<String, dynamic>> Collections;

  const Uniquecollectionscards({super.key,required this.Collections});

  @override
  State<Uniquecollectionscards> createState() => _UniquecollectionscardsState();
}

class _UniquecollectionscardsState extends State<Uniquecollectionscards> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GridView.builder(
      scrollDirection:Axis.horizontal,
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,      // 6 items vertically
        childAspectRatio: 0.9,
        crossAxisSpacing: 5
      ),
      itemCount: widget.Collections.length,

      itemBuilder: (context, index) {
        final img = widget.Collections[index]["img"];
        final text = widget.Collections[index]["text"] ?? "";
        final logo = widget.Collections[index]["img2"] ?? "";

        return Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(
            right: w * 0.015,
            left:w*0.015,
            bottom: h * 0.04,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Frame Overlay
              Positioned.fill(
                child: Image.asset(
                  "assets/bgs/blckbg.jpg",
                  fit: BoxFit.fill,
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
                    text,
                    style: GoogleFonts.gfsDidot(
                      fontWeight: FontWeight.w900,
                      fontSize: h * 0.014,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // LOGO BADGE
              Positioned(
                bottom: -h * 0.02,
                left: w * 0.04,
                right: w * 0.04,
                child: Container(
                  height: h * 0.025,
                  decoration: BoxDecoration(
                      color:Colors.white
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(logo,fit: BoxFit.cover,),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

