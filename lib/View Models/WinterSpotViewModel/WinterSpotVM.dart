// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class Winterspotvm extends ChangeNotifier{
  List<Map<String, dynamic>> season = [];


  Winterspotvm() {
    loadData();
  }

  void loadData() {
   season = [
      {"img":"assets/placeholders/products/wintermen.jpg"},
      {"img": "assets/bgs/winter fits.jpg"},
      {"img": "assets/bgs/warm bennie.jpg"},
      {"img": "assets/placeholders/products/hoodies.png"},
      {"img": "assets/placeholders/products/sweat.png"},
     {"img":"assets/placeholders/products/wintermen.jpg"},
     {"img": "assets/bgs/winter fits.jpg"},
     {"img": "assets/bgs/warm bennie.jpg"},
     {"img": "assets/placeholders/products/hoodies.png"},
     {"img": "assets/placeholders/products/sweat.png"},

   ];
  }
}