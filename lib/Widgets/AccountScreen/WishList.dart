import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/View/CartScreen/CartScreen.dart';

import '../../Utils/Constants/app_colors.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';

class Wishlistlayout extends StatefulWidget {
  final String title;
  final String ? description;
  final String image;
  final String price;

  const Wishlistlayout({super.key,
    required this.title,
     this.description,
    required this.image,
    required this.price,});

  @override
  State<Wishlistlayout> createState() => _WishlistlayoutState();
}

class _WishlistlayoutState extends State<Wishlistlayout> {
  int quantity = 1;
  String selectedSize = "M";
  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  bool isWishlisted = false;
  bool isAddedToCart = false;



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PRODUCT IMAGE
          Container(
            height: screenHeight * 0.09,
            width: screenWidth * 0.2,
            decoration: BoxDecoration(
              border:Border.all(color:Colors.grey.shade100),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(
                  widget.image.isNotEmpty
                      ? widget.image
                      : 'assets/PlaceHolder/Product_placeholder.avif',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          // PRODUCT DETAILS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF105594),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Price: ${widget.price}',
                style: GoogleFonts.fugazOne(
                  fontSize: screenHeight * 0.014,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF105594),
                ),
              ),
              // QUANTITY BUTTONS
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                    child: Icon(Icons.remove, color: AppColors.textField,size:screenHeight*0.02,),
                  ),
                  SizedBox(width:screenWidth*0.01),
                  Text("$quantity",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize:screenHeight*0.015)),
                  SizedBox(width:screenWidth*0.01),
                  GestureDetector(
                    onTap: () => setState(() => quantity++),
                    child: Icon(Icons.add, color: AppColors.textField,size:screenHeight*0.02,),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // DELETE + WISHLIST
          Column(
            children: [
              // DELETE PRODUCT
              GestureDetector(
                onTap: () {
                  final wishlistVM = Provider.of<WishlistVM>(context, listen: false);
                  wishlistVM.removeItem(widget.title);
                },
                child: Image.asset(
                  "assets/icons/bin.png",
                  height: screenHeight * 0.022,
                  color: Colors.red.shade800,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              //ADD TO CART
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child:GestureDetector(
                  onTap: () {
                    setState(() => isAddedToCart = true);

                    final cartVM = Provider.of<Cartlistviewmodel>(context, listen: false);
                    cartVM.updateCartItemInWishlist(
                      img: widget.image,
                      name: widget.title,
                      price: widget.price,
                      size: selectedSize,
                      qty: quantity,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Cartscreen()),
                    );
                  },
                  child: Image.asset(
                    isAddedToCart
                        ? "assets/icons/added item.png"
                        : "assets/icons/add to cart.png",
                    height: screenHeight * 0.025,
                    color: Colors.pink,
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
