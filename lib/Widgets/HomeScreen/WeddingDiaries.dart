// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';

class Weddingdiaries extends StatefulWidget {
  final List<Map<String, dynamic>> Wedding;
  const Weddingdiaries({super.key, required this.Wedding});

  @override
  State<Weddingdiaries> createState() => _WeddingdiariesState();
}

class _WeddingdiariesState extends State<Weddingdiaries> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * 0.25,
      width: w * 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.Wedding.length,
        itemBuilder: (context, index) {
          final img = widget.Wedding[index]["img"];
          final text = widget.Wedding[index]["text"] ?? "";

          return Container(
            width: w * 0.65, // width of each item
            margin: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Stack(
                  children: [
                    //MAIN IMAGE WITH ROUNDED TOP CORNERS
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: Image.asset(
                        "assets/bgs/RED_DOM-removebg-preview.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 450,
                      ),
                    ),

                    //TOP-LEFT OVERLAY
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),

                    //TOP-RIGHT OVERLAY
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //IMAGE
                Positioned(
                  top: h * 0.015,
                  left: w * 0.04,
                  right: w * 0.04,
                  bottom: h * 0.01,
                  child: ClipRRect(
                    child: Image.asset(img, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  bottom: h * 0.009,
                  left: w * 0.04,
                  right: w * 0.04,
                  child: Container(
                    height: h * 0.05,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.5),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign:TextAlign.center,
                      style: GoogleFonts.gfsDidot(
                        fontWeight: FontWeight.w900,
                        fontSize: h * 0.016,
                        color:AppColors.textField,
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
