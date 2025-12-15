// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class TodaystopstealsVM extends ChangeNotifier {
  List<Map<String, dynamic>> TopProducts = [];

  TodaystopstealsVM() {
    loadData();
  }

  void loadData(){
    TopProducts =[
      {"img":"assets/placeholders/products/maxi.png","text":"MaxiDress"},
      {"img":"assets/placeholders/products/hoodies.png","text":"Hoodies"},
      {"img":"assets/placeholders/products/pre plated.png","text":"Pre-Draped Sarees"},
      {"img":"assets/placeholders/products/suit st.png","text":"Suit Set"},
      {"img":"assets/placeholders/products/sweat.png","text":"SweatShirts"},
      {"img":"assets/placeholders/products/ss.png","text":"Statement Shirts"},
      {"img":"assets/placeholders/products/bra.png","text":"Multi-way Bras"},
      {"img":"assets/placeholders/products/comfy.png","text":"Comfy Lingere"},
      {"img":"assets/placeholders/products/bed.png","text":"Bed Suites"},
    ];
  }
}