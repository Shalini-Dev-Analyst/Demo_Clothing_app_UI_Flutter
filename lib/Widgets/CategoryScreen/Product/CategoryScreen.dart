import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/Constants/app_colors.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> Categories;
  const CategoryScreen({super.key, required this.Categories});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.9,
        mainAxisSpacing: h * 0.02,
        crossAxisSpacing: w * 0.02,
      ),
      itemCount: Categories.length,
      itemBuilder: (context, index) {
        final img = Categories[index]["img"];
        final text = Categories[index]["text"];

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: w * 0.015,
            vertical: h * 0.01,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image:AssetImage("assets/bgs/offer_box-removebg-preview.png"),fit:BoxFit.cover)
                  ),
                ),
              ),
              Positioned(
                left: w * 0.02,
                right: w * 0.02,
                top: h* 0.01,
                bottom: 0,
                child: Image.asset(img, fit: BoxFit.contain),
              ),
              Positioned(
                bottom: -h * 0.015,
                left: 0.01,
                right: 0,
                child: Container(
                  height: h * 0.023,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:Colors.white
                    // image: DecorationImage(
                    //   image: AssetImage("assets/bgs/PINKGLITTER.jpg"),
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  child: Text(
                    text,
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w900,
                      fontSize: h * 0.01,
                      color: AppColors.textField,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
