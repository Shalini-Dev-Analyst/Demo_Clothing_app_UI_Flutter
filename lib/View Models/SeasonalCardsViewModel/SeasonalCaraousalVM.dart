// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class SeasonalCardsViewModel extends ChangeNotifier{
  List<Map<String, dynamic>> seasons = [];

  SeasonalCardsViewModel(){
    loadData();
  }

  void loadData(){
    seasons = [
      {"img":"assets/bgs/bedroom bliss.jpg","text1":"Chase","text2":"Comfort"},
      {"img":"assets/bgs/partie wear.jpg","text1":"Be","text2":"The Main Character"},
      {"img":"assets/bgs/warm bennie.jpg","text1":"The","text2":"Warm Bennie"},
      {"img":"assets/bgs/winter fits.jpg","text1":"Winter","text2":"Drip"},
      {"img":"assets/bgs/relaxed outfits.jpg","text1":"Stay","text2":"Relaxed"},
    ];
  }
}