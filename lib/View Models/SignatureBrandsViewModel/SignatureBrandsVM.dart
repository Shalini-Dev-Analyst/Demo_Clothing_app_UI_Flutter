// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class Signaturebrandsvm extends ChangeNotifier {
  List<Map<String, dynamic>> logos= [];

  Signaturebrandsvm() {
    loadData();
  }

  void loadData(){
    logos =[
      {"img":"assets/logo/CHANNEL-removebg-preview (1).png"},
      {"img":"assets/logo/GUCCI-removebg-preview (1).png"},
      {"img":"assets/logo/4e67c8454a25058b5249a67ffa251be8-removebg-preview.png"},
      {"img":"assets/logo/VSS-removebg-preview.png"},
    ];
  }
}