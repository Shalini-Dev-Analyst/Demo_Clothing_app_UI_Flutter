// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class CategoryVM extends ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> menCategories = {};
  Map<String, List<Map<String, dynamic>>> womenCategories = {};
  Map<String, List<Map<String, dynamic>>> kidCategories = {};
  Map<String, List<Map<String, dynamic>>> tradCategories = {};
  Map<String, List<Map<String, dynamic>>> funCategories = {};
  Map<String, List<Map<String, dynamic>>> genCategories = {};

  CategoryVM() {
    loadData();
  }

  void loadData() {
    menCategories = {
      "Casual Wear": [
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/sweat.png", "text": "Sweatshirts"},
        {"img": "assets/placeholders/products/ss.png", "text": "T-Shirts"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/sweat.png", "text": "Sweatshirts"},
        {"img": "assets/placeholders/products/ss.png", "text": "T-Shirts"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/sweat.png", "text": "Sweatshirts"},
      ],
      "Work Wear":[
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
      ],
      "Occasion Wear" : [
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
      ],
      "Sports Wear" : [
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
      ],
      "GenZ-Fashion" : [
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
      ],
      "Western Wear": [
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
        {"img": "assets/placeholders/products/pre plated.png", "text": "Oversized Tees"},
        {"img": "assets/placeholders/products/maxi.png", "text": "Shirts"},
        {"img": "assets/placeholders/products/suit st.png", "text": "Jeans"},
      ],
    };
    womenCategories = {
      "Ethnic Wear": [
        {"img": "assets/placeholders/products/maxi.png", "text": "Kurtis"},
        {"img": "assets/placeholders/products/ss.png", "text": "Sarees"},
        {"img": "assets/placeholders/products/bed.png", "text": "Lehanga"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
      ],
      "Western Wear": [
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
      ],
      "Lingere & Loungewear" : [
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
      ],
      "GenZ-Fashions" : [
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Skirts"},
        {"img": "assets/placeholders/products/comfy.png", "text": "Dresses"},
        {"img": "assets/placeholders/products/bra.png", "text": "Tops"},
      ]
    };
    kidCategories = {
      "For Infants": [
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
    ],
      "For Girls":[
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
      "For Teens":[
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
      "For Boys":[
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
    };
    tradCategories ={
      "Traditional Vibes": [
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
    };
    funCategories ={
      "Function Wear": [
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
      "Pongal Wear":[
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
      "Wedding Diaries":[
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ]
    };
    genCategories ={
      "Casual Wear": [
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
        {"img": "assets/placeholders/products/hoodies.png", "text": "Hoodies"},
      ],
    };
    }
  }

