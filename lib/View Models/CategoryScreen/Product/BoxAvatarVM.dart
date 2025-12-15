// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class BoxAvatarVM extends ChangeNotifier {
  List<Map<String, dynamic>> menmaintype= [];
  List<Map<String, dynamic>> womenmaintype= [];
  List<Map<String, dynamic>> vibemaintype= [];
  List<Map<String, dynamic>> littlemaintype= [];
  List<Map<String, dynamic>> ethnosmaintype= [];
  List<Map<String, dynamic>> royalemaintype= [];

  BoxAvatarVM() {
    loadData();
  }

  void loadData(){
    menmaintype =[
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},
      {"img":"assets/placeholders/products/men fashion.jpg","text":"men"},

    ];
    womenmaintype =[
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
      {"img":"assets/placeholders/products/women casual.jpg","text":"women"},
    ];

    vibemaintype =[
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},
      {"img":"assets/placeholders/products/genz-removebg-preview (1).png","text":"genz"},

    ];
    littlemaintype =[
      {"img":"assets/placeholders/products/kid fashion.jpg","text":"little"},
      {"img":"assets/placeholders/products/kid fashion.jpg","text":"little"},
      {"img":"assets/placeholders/products/kid fashion.jpg","text":"little"},
      {"img":"assets/placeholders/products/kid fashion.jpg","text":"little"},


    ];
    ethnosmaintype =[
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},
      {"img":"assets/placeholders/products/trends-removebg-preview.png","text":"Tradition"},

    ];
    royalemaintype =[
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},
      {"img":"assets/placeholders/products/occation-removebg-preview.png","text":"Occation"},

    ];
  }
}