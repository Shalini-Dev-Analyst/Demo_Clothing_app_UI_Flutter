import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int selectedCategory = 0;

  final List<String> categories = [
    "Brand",
    "Size",
    "Color",
    "Gender",
    "Fabric"
  ];

  final Map<String, List<String>> options = {
    "Brand": ["Nike", "Adidas", "Puma", "Zara", "H&M"],
    "Size": ["S", "M", "L", "XL", "XXL"],
    "Color": ["Black", "White", "Blue", "Red", "Green"],
    "Gender": ["Men", "Women", "Kids", "Unisex"],
    "Fabric": ["Cotton", "Silk", "Polyester", "Wool"]
  };

  // Track selected options
  Map<String, Set<String>> selected = {
    "Brand": {},
    "Size": {},
    "Color": {},
    "Gender": {},
    "Fabric": {},
  };

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Row(
          children: [
            // LEFT CATEGORY MENU
            Container(
              width:screenWidth*0.3,
              color: Colors.grey.shade100,
              child: ListView.builder(
                controller: scrollController,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedCategory == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical:screenHeight*0.02, horizontal:screenWidth*0.05),
                      color: isSelected ? Colors.white : Colors.grey.shade100,
                      child: Text(
                        categories[index],
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          fontSize:screenHeight*0.018,
                          fontWeight: isSelected ? FontWeight.w400 : FontWeight.normal,
                          color: isSelected ? AppColors.textFieldHint : AppColors.pagehead,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // RIGHT OPTIONS PANEL
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical:screenHeight*0.02, horizontal:screenWidth*0.05),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text(
                      categories[selectedCategory],
                      style: GoogleFonts.getFont(
                        AppFonts.body,
                        fontSize:screenHeight*0.02,
                        fontWeight: FontWeight.w500,
                        color:AppColors.textField
                      ),
                    ),

                    SizedBox(height:screenHeight*0.01),

                    ...options[categories[selectedCategory]]!.map((item) {
                      bool checked = selected[categories[selectedCategory]]!.contains(item);

                      return CheckboxListTile(
                        checkColor:Colors.white,
                        activeColor: Colors.blue,
                        value: checked,
                        title: Text(item,style:GoogleFonts.getFont(AppFonts.body,color:AppColors.pagesubtext),),
                        onChanged: (bool? v) {
                          setState(() {
                            if (v == true) {
                              selected[categories[selectedCategory]]!.add(item);
                            } else {
                              selected[categories[selectedCategory]]!.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),

                    SizedBox(height:screenHeight*0.02),

                    //APPLY & RESET BUTTON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected.forEach((key, value) => value.clear());
                            });
                          },
                          child: Text("Reset",
                              style:GoogleFonts.getFont(
                                  AppFonts.body,
                                  fontSize:screenHeight*0.018,
                                  color:AppColors.textFieldHint)),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade300,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Apply",
                              style:GoogleFonts.getFont(
                              AppFonts.body,
                              fontSize:screenHeight*0.018,
                              color:Colors.white),),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
