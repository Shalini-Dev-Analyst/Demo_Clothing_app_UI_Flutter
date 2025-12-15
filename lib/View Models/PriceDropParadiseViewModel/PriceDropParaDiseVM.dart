// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class PricedropparadiseVM extends ChangeNotifier {
  List<Map<String, dynamic>> Brands = [];

  PricedropparadiseVM() {
    loadData();
  }

  void loadData(){
    Brands =[
      {"img":"assets/placeholders/products/girl fashion.jpg","text":"Off Upto 40%"},
      {"img":"assets/placeholders/products/girl trad.jpg","text":"Under 799"},
      {"img":"assets/placeholders/products/men casual.jpg","text":"Under 999"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"Off Upto 50%"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"Under 699"},
      {"img":"assets/placeholders/products/women fashion.jpg","text":"Under 1999"},
      {"img":"assets/placeholders/products/women trad.jpg","text":"Min 70% Off"},
      {"img":"assets/placeholders/products/comfy.png","text":"Min 40% Off"},
      {"img":"assets/placeholders/products/bed.png","text":"Off Upto 30%"},
    ];
  }
}