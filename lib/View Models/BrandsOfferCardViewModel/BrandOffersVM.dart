// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class BrandOfferCardsvm extends ChangeNotifier {
  List<Map<String, dynamic>> BrandOffers = [];

  BrandOfferCardsvm() {
    loadData();
  }

void loadData(){
    BrandOffers =[
      {"img":"assets/logo/adidaas.jpg"},
      {"img":"assets/logo/dior.jpg"},
      {"img":"assets/logo/nike.jpg"},
      {"img":"assets/logo/polo.jpg"},
      {"img":"assets/logo/puma.jpg"},
      {"img":"assets/logo/reebok.jpg"},
      {"img":"assets/logo/tommyhill.jpg"},
      {"img":"assets/logo/zara.jpg"},
      {"img":"assets/logo/victory secret.jpg"},
    ];
}
}