// ignore_for_file: file_names, strict_top_level_inference, duplicate_ignore

import 'package:flutter/material.dart';

class WishlistVM extends ChangeNotifier {
  List<Map<String, dynamic>> wishlist = [];
  List items = [];

  int get count => items.length;

  // ignore: strict_top_level_inference
  void add(item) {
    items.add(item);
    notifyListeners();
  }

  void remove(item) {
    items.remove(item);
    notifyListeners();
  }
  void addItem(Map<String, dynamic> product) {
    // Avoid duplicates
    bool exists = wishlist.any((p) => p['name'] == product['name']);
    if (!exists) {
      wishlist.add(product);
      notifyListeners();
    }
  }

  void removeItem(String name) {
    wishlist.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }
}