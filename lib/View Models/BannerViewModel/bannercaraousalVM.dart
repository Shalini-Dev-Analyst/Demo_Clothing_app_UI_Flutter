// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class BannersViewModel extends ChangeNotifier{
  List<Map<String, dynamic>> banners = [];
  List<Map<String, dynamic>> dealsBanner = [];
  List<Map<String, dynamic>> productbanners =[];

  BannersViewModel() {
    loadData();
  }

  void loadData() {
    banners = [
      {"img": "assets/bgs/banner6.jpg"},
      {"img":"assets/bgs/banner2.jpg"},
      {"img": "assets/bgs/banners1.jpg"},
      {"img":"assets/bgs/banner7.jpg"},
    ];

    productbanners = [
      {"img":"assets/banners/banner/3ef222b856583ff673e05c62c0fb80e4.jpg"},
      {"img": "assets/banners/banner/6f34999f6eb95bddb2d367fda0dc9c29.jpg"},
      {"img": "assets/banners/banner/db3aff37332ba815b42ca6605211446c.jpg"},
    ];
    // dealsBanner =[
    //   {"img":"assets/banners/deals/main deal.avif",},
    //   {"img":"assets/banners/deals/deals2.webp"},
    //   {"img":"assets/banners/deals/deal4.jpg"},
    // ];
    // offers =[
    //   {"img":"assets/banners/deals/offer 3.webp",},
    //   {"img":"assets/banners/deals/offer2.jpg"},
    //   {"img":"assets/banners/deals/offers.webp"},
    // ];
  }
}