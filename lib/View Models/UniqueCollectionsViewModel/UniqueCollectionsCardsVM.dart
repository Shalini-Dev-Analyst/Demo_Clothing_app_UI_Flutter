// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class UniquecollectionscardsVm extends ChangeNotifier {
  List<Map<String, dynamic>> Collections= [];

  UniquecollectionscardsVm() {
    loadData();
  }

  void loadData(){
   Collections =[
      {"img":"assets/placeholders/products/maxi.png","text":"MaxiDress","img2":"assets/logo/CHANNEL-removebg-preview (1).png"},
      {"img":"assets/placeholders/products/hoodies.png","text":"Hoodies","img2":"assets/logo/lv.jpg"},
      {"img":"assets/placeholders/products/pre plated.png","text":"Pre-Draped Sarees","img2":"assets/logo/VSS-removebg-preview.png"},
      {"img":"assets/placeholders/products/suit st.png","text":"Suit Set","img2":"assets/logo/4e67c8454a25058b5249a67ffa251be8-removebg-preview.png"},
      {"img":"assets/placeholders/products/sweat.png","text":"SweatShirts","img2":"assets/logo/GUCCI-removebg-preview (1).png"},
      {"img":"assets/placeholders/products/ss.png","text":"Statement Shirts","img2":"assets/logo/polo.jpg"},
      {"img":"assets/placeholders/products/bra.png","text":"Multi-way Bras","img2":"assets/logo/zara.jpg"},
      {"img":"assets/placeholders/products/comfy.png","text":"Comfy Lingere","img2":"assets/logo/zara.jpg"},
     {"img":"assets/placeholders/products/maxi.png","text":"MaxiDress","img2":"assets/logo/CHANNEL-removebg-preview (1).png"},
     {"img":"assets/placeholders/products/hoodies.png","text":"Hoodies","img2":"assets/logo/lv.jpg"},
     {"img":"assets/placeholders/products/pre plated.png","text":"Pre-Draped Sarees","img2":"assets/logo/VSS-removebg-preview.png"},
      {"img":"assets/placeholders/products/bed.png","text":"Bed Suites","img2":"assets/logo/zara.jpg"},
    ];
  }
}