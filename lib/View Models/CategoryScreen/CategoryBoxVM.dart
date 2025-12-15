// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../Utils/Constants/app_colors.dart';

class CategoryboxVM extends ChangeNotifier {
  List<Map<String, dynamic>> category = [];

  CategoryboxVM() {
    loadData();
  }

  void loadData() {
    category = [
      {
        "img":"assets/placeholders/products/men2-removebg-preview.png",
        "text":"Gentlemen",
        "text1":"Dress like you’ve already made it",
        "color":Color(0XFFD14D72),
        "color2":Colors.white,
        "mainTypeKey": "Men" // key for BoxAvatarVM
      },
      {
        "img":"assets/placeholders/products/women-removebg-preview.png",
        "text":"Elegance - Women",
        "text1":"Born to shine, styled to slay",
        "color": AppColors.containerOverlay,
        "color2":AppColors.textField,
        "mainTypeKey": "Women" // key for BoxAvatarVM
      },
      // ... other categories without left scroll mapping can have mainTypeKey:null
      {
        "img":"assets/placeholders/products/499979c9d76311331ed17ec87988f586-removebg-preview (1).png",
        "text":"LittleWear",
        "text1":"Outfits as cool as their imagination",
        "color": Color(0XFFE8A0BF),
        "color2":Colors.white,
        "mainTypeKey": "Kids"
      },
      {
        "img":"assets/placeholders/products/occation-removebg-preview.png",
        "text":"Ethnos-Traditional Trends",
        "text1":"Grace is the best accessory\nfor any traditional outfit",
        "color": Color(0XFFFFF2E0),
        "color2":AppColors.textFieldHint,
        "mainTypeKey": "Traditional"
      },
      {
        "img":"assets/placeholders/products/genz-removebg-preview (1).png",
        "text":"Vibe- The GenZ",
        "text1":"Minimal look,maximal energy",
        "color": Color(0XFFA294F9),
        "color2":AppColors.containerOverlay,
        "mainTypeKey": "GenZ"
      },
      {
        "img":"assets/placeholders/products/trends-removebg-preview.png",
        "text":"Royale - Occation Mode",
        "text1":"Festival vibes,fashionable tribes",
        "color": Color(0XFFFFF2C2),
        "color2":AppColors.textField,
        "mainTypeKey": "Function"
      },
    ];
  }
}
