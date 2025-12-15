// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class ElitespotlightVM extends ChangeNotifier {
  List<Map<String, dynamic>> Elite = [];

  ElitespotlightVM() {
    loadData();
  }

  void loadData(){
    Elite =[
      {"img":"assets/placeholders/products/maxi.png","text":"MaxiDress",},
      {"img":"assets/placeholders/products/hoodies.png","text":"Hoodies",},
      {"img":"assets/placeholders/products/pre plated.png","text":"Pre-Draped Sarees",},
      {"img":"assets/placeholders/products/suit st.png","text":"Suit Set",},
      {"img":"assets/placeholders/products/sweat.png","text":"SweatShirts",},
      {"img":"assets/placeholders/products/ss.png","text":"Statement Shirts",},
      {"img":"assets/placeholders/products/frocks_wed-removebg-preview.png","text":"Design Frock",},
      {"img":"assets/placeholders/products/comfy.png","text":"Comfy Lingere",},
      {"img":"assets/placeholders/products/maxi.png","text":"MaxiDress",},
      {"img":"assets/placeholders/products/hoodies.png","text":"Hoodies",},
      {"img":"assets/placeholders/products/pre plated.png","text":"Pre-Draped Sarees",},
      {"img":"assets/placeholders/products/8cf6e5275fd62319acb1c0f9072c3eee-removebg-preview.png","text":"Frocks",}
    ];
  }
}