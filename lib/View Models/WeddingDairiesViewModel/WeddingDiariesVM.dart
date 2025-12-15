// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class WeddingdiariesVM extends ChangeNotifier {
  List<Map<String, dynamic>> Wedding = [];

  WeddingdiariesVM() {
    loadData();
  }

  void loadData(){
    Wedding =[
      {"img":"assets/placeholders/products/marge_occation-removebg-preview (1).png","text":"South Indian\nMarriage Collection"},
      {"img":"assets/placeholders/products/wedding_saree-removebg-preview.png","text":"Silk Wedding\nSaree"},
      {"img":"assets/placeholders/products/wedding_dhothi-removebg-preview.png","text":"South Indian\nDhoti"},
      {"img":"assets/placeholders/products/engage_occation-removebg-preview (1).png","text":"Matchy Engage"},
      {"img":"assets/placeholders/products/wedding_lehanga-removebg-preview.png","text":"Lehangas"},
      {"img":"assets/placeholders/products/wedding_kurta-removebg-preview.png","text":"Wedding Pyjama"},
      {"img":"assets/placeholders/products/shaadi_occation-removebg-preview (1).png","text":"Matchy Catchy\nHenna"},
      {"img":"assets/placeholders/products/wedding_choli-removebg-preview.png","text":"Choli Waala"},
      {"img":"assets/placeholders/products/frocks_wed-removebg-preview.png","text":"Wedding Frock\n Gujarati"},
      {"img":"assets/placeholders/products/wedding_suits-removebg-preview.png","text":"Wedding Suit"},
      {"img":"assets/placeholders/products/8cf6e5275fd62319acb1c0f9072c3eee-removebg-preview.png","text":"Wedding Frock"},
    ];
  }
}