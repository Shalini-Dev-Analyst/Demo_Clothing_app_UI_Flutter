import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/View/Category%20Screen/CategoryDetailScreen.dart';
import 'package:s_apparels_clothes/Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../../View Models/CategoryScreen/CategoryBoxVM.dart';

class Categorybox extends StatelessWidget {
  const Categorybox({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CategoryboxVM>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return StaggeredSlideIn(
      beginOffset: const Offset(0.4, 0),
      itemDelay: const Duration(milliseconds: 150),
      itemDuration: const Duration(milliseconds: 550),
      children: List.generate(vm.category.length, (index) {
        final item = vm.category[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Categorydetailscreen(
                    selectedCategory: item['mainTypeKey'],
                  ),
                ),
              );
            },
        child:Padding(
          padding: EdgeInsets.symmetric(vertical:screenHeight*0.02,horizontal:screenWidth*0.04),
          child: Container(
            height: screenHeight * 0.13,
            width: screenWidth*09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: item['color'].withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color:item['color'].withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset:Offset(1, 4)
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children:[
                Positioned(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.03,
                  right: screenWidth* 0,
                  bottom: -screenHeight * 0.017,
                  child: Text(
                    item['text'],
                    style: GoogleFonts.gfsDidot(
                      fontSize: screenHeight * 0.019,
                      color:item['color2'],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.06,
                  left: screenWidth * 0.05,
                  right: screenWidth* 0,
                  bottom: -screenHeight * 0.017,
                  child: Text(
                    item['text1'],
                    textAlign:TextAlign.start,
                    style: GoogleFonts.getFont(
                        AppFonts.contents,
                        fontSize: screenHeight * 0.014,
                        fontWeight: FontWeight.w400,
                        color:item['color2']
                    ),
                  ),
                ),
                Positioned(
                  top: -screenHeight * 0.02,
                  left: screenWidth * 0.6,
                  right: screenWidth* 0,
                  bottom: -screenHeight * 0.02,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item['img'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          ],
            ),
          ),
        ),
        );
      }),
    );
  }
}
