// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class PartyreadyVM extends ChangeNotifier{
  List<Map<String, dynamic>> Party = [];


  PartyreadyVM() {
    loadData();
  }

  void loadData() {
    Party = [
      {"img":"assets/placeholders/products/p2.jpg"},
      {"img": "assets/placeholders/products/p3.jpg"},
      {"img": "assets/placeholders/products/p4.jpg"},
      {"img": "assets/placeholders/products/p5.jpg"},
      {"img": "assets/placeholders/products/p6.jpg"},
      {"img":"assets/placeholders/products/p7.jpg"},
      {"img": "assets/placeholders/products/p8.png"},
      {"img": "assets/placeholders/products/p9.jpg"},
      {"img": "assets/placeholders/products/p10.png"},
      {"img": "assets/placeholders/products/p12.jpg"},
      {"img": "assets/placeholders/products/party.jpg"},
      {"img": "assets/placeholders/products/p5.jpg"},
      {"img": "assets/placeholders/products/p6.jpg"},
      {"img":"assets/placeholders/products/p7.jpg"},
    ];
  }
}