// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class CuratedexclusiveVM extends ChangeNotifier {
  List<Map<String, dynamic>> Exclusives = [];

  CuratedexclusiveVM() {
    loadData();
  }

  void loadData(){
    Exclusives =[
      {"img":"assets/placeholders/products/maxi.png","text":"Libas"},
      {"img":"assets/placeholders/products/hoodies.png","text":"Lipsy"},
      {"img":"assets/placeholders/products/pre plated.png","text":"Estele"},
      {"img":"assets/placeholders/products/suit st.png","text":"Rain & Rainbow"},
      {"img":"assets/placeholders/products/sweat.png","text":"Femmella"},
      {"img":"assets/placeholders/products/ss.png","text":"Snitch"},
      {"img":"assets/placeholders/products/bra.png","text":"Zivame"},
      {"img":"assets/placeholders/products/comfy.png","text":"Blissclub"},
      {"img":"assets/placeholders/products/bed.png","text":"RSVP"},
    ];
  }
}