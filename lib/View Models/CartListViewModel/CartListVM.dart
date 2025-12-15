// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Cartlistviewmodel extends ChangeNotifier {
  List<Map<String, dynamic>> productlist = [];
  List<Map<String, dynamic>> cart = [];

  // ---------------------------------------------
  // 🔥 NEW — Persisted values
  // ---------------------------------------------
  String selectedAddress = "";
  String selectedPaymentMethod = "";

  Cartlistviewmodel() {
    loadData();
  }

  // ---------------------------------------------
  // 🔥 Calculate Total Price
  // ---------------------------------------------
  double getTotalPrice() {
    double total = 0;

    for (var item in cart) {
      String p = item["price"]
          .toString()
          .replaceAll("₹", "")
          .replaceAll(",", "")
          .trim();

      double price = double.tryParse(p) ?? 0.0;
      int qty = item["qty"] ?? 1;

      total += price * qty;
    }

    return total;
  }

  // ---------------------------------------------
  // Add item to cart
  // ---------------------------------------------
  void addToCart(Map<String, dynamic> product) {
    final name = product['name'] ?? '';

    final exists = cart.any((p) => p['name'] == name);
    if (!exists) {
      cart.add({
        "img": product["img"] ?? '',
        "name": product["name"] ?? '',
        "price": product["price"] ?? '0',
        "size": product["size"] ?? 'M',
        "qty": product["qty"] ?? 1,
      });

      notifyListeners();
    }
  }

  // ---------------------------------------------
  // Remove by name
  // ---------------------------------------------
  void removeItemByName(String name) {
    cart.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }

  // ---------------------------------------------
  // Remove by index
  // ---------------------------------------------
  void removeItemAtIndex(int index) {
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      notifyListeners();
    }
  }

  // ---------------------------------------------
  // Update item by index
  // ---------------------------------------------
  void updateItem(int index, String size, int qty) {
    if (index >= 0 && index < cart.length) {
      cart[index]['size'] = size;
      cart[index]['qty'] = qty;
      notifyListeners();
    }
  }

  // ---------------------------------------------
  // Update cart item by name
  // ---------------------------------------------
  void updateCartItem(String name, String newSize, int newQty) {
    final index = cart.indexWhere((item) => item["name"] == name);
    if (index != -1) {
      cart[index]["size"] = newSize;
      cart[index]["qty"] = newQty;
      notifyListeners();
    }
  }

  // ---------------------------------------------
  // Load dummy products
  // ---------------------------------------------
  void loadData() {
    productlist = [
      {"img": "", "name": "Party Wear", "price": "₹1500"},
      {"img": "", "name": "Party Wear 2", "price": "₹1500"},
    ];

    notifyListeners();
  }

  // ---------------------------------------------
  // NEW — Save Address
  // ---------------------------------------------
  void setAddress(String address) {
    selectedAddress = address;
    notifyListeners();
  }

  // ---------------------------------------------
  // NEW — Save Payment Method
  // ---------------------------------------------
  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void updateCartItemInWishlist({
    required String img,
    required String name,
    required String price,
    required String size,
    required int qty,
  }) {
    // Check if item already exists in cart with same size
    int index = cart.indexWhere(
            (item) => item["name"] == name && item["size"] == size);

    if (index != -1) {
      // Update quantity
      cart[index]["qty"] = qty;
    } else {
      // Add new item
      cart.add({
        "img": img,
        "name": name,
        "price": price,
        "size": size,
        "qty": qty,
      });
    }

    notifyListeners();
  }

}
