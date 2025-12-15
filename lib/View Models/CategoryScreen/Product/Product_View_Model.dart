// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../Models/Product/Product_Model.dart';


class ProductVM extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      title: 'Valley Suites',
      description: 'Specifies the garment, like a "POOMSAE (Demo) Dress" for martial arts or a "demo Krishna dress" for a deity costume..',
      image: 'assets/placeholders/products/comfy.png',
      price: '₹499',
    ),
    Product(
      id: '2',
      title: 'Jump suites',
      description: 'Specifies the garment, like a "POOMSAE (Demo) Dress" for martial arts or a "demo Krishna dress" for a deity costume.',
      image: 'assets/placeholders/products/women fashion.jpg',
      price: '₹899',
    ),
    Product(
      id: '3',
      title: 'Men Casual',
      description: 'Specifies the garment, like a "POOMSAE (Demo) Dress" for martial arts or a "demo Krishna dress" for a deity costume.',
      image: 'assets/placeholders/products/men fashion.jpg',
      price: '₹299',
    ),
    Product(
      id: '1',
      title: 'Valley Suites',
      description: 'Specifies the garment, like a "POOMSAE (Demo) Dress" for martial arts or a "demo Krishna dress" for a deity costume.',
      image: 'assets/placeholders/products/comfy.png',
      price: '₹499',
    ),
    Product(
      id: '2',
      title: 'Jump suites',
      description: 'Specifies the garment, like a "POOMSAE (Demo) Dress" for martial arts or a "demo Krishna dress" for a deity costume.',
      image: 'assets/placeholders/products/women fashion.jpg',
      price: '₹899',
    ),
    Product(
      id: '3',
      title: 'Men Casual',
      description: 'Specifies the garment, like a "POOMSAE (Demo) Dress" for martial arts or a "demo Krishna dress" for a deity costume.',
      image: 'assets/placeholders/products/men fashion.jpg',
      price: '₹299',
    ),
  ];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
