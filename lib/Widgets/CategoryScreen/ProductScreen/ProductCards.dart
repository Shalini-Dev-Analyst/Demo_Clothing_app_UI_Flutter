import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';

import '../../../Utils/Constants/app_fonts.dart';
import '../../../View Models/AccountScreen/WishlistVM.dart';
import '../../../View Models/CartListViewModel/CartListVM.dart';
import '../../../View/Category Screen/ProductScreen/ProductDetailScreen.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String price;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;
  bool isAddedToBag = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cartVM = Provider.of<Cartlistviewmodel>(context);

    isAddedToBag = cartVM.cart.any((item) => item["name"] == widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              title: widget.title,
              description: widget.description,
              image: widget.image,
              price: widget.price,
            ),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.55,
        height: screenHeight * 0.55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.red.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Product Image
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: screenWidth * 0.35,
                    height: screenWidth * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Title
            Positioned(
              top: screenHeight * 0.2,
              left:screenWidth*0.08,
              child: SizedBox(
                width: screenWidth * 0.3,
                child: Center(
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.gfsDidot(
                      fontWeight: FontWeight.w700,
                      fontSize: screenHeight * 0.016,
                      color: AppColors.pagehead,
                    ),
                  ),
                ),
              ),
            ),
            // Description
            Positioned(
              top: screenHeight * 0.23,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
              child: SizedBox(
                width: screenWidth * 0.3,
                child: Text(
                  widget.description,
                  style: GoogleFonts.getFont(
                    AppFonts.contents,
                    fontSize: screenHeight * 0.014,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Price Circle
            Positioned(
              top: 10,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.pink.shade300,
                child: Text(
                  widget.price,
                  style: GoogleFonts.fugazOne(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: screenHeight * 0.012,
                  ),
                ),
              ),
            ),
            // Wishlist Button
            Positioned(
              bottom: screenHeight * 0.1,
              left: screenHeight * 0.01,
              child: GestureDetector(
                onTap: () {
                  final wishlistVM =
                  Provider.of<WishlistVM>(context, listen: false);

                  setState(() {
                    isWishlisted = !isWishlisted;
                  });

                  // ADD or REMOVE from Wishlist
                  if (isWishlisted) {
                    wishlistVM.addItem({
                      "name": widget.title,
                      "price": widget.price,
                      "img": widget.image,
                    });
                  } else {
                    wishlistVM.removeItem(widget.title);
                  }

                },
                child: Image.asset(
                  isWishlisted
                      ? "assets/icons/wishlist heart red.png"
                      : "assets/icons/wishlist heart white.png",
                  height: screenHeight * 0.025,
                  color: Colors.pink,
                ),
              ),
            ),
            //ADD TO BAG
            Positioned(
              bottom: screenHeight * 0.1,
              right:screenHeight * 0.01,
              child: GestureDetector(
                onTap: () {
                  final cartVM = Provider.of<Cartlistviewmodel>(context, listen: false);

                  cartVM.addToCart({
                    "img": widget.image,
                    "name": widget.title,
                    "price": widget.price,
                    "size": "M",   // default
                    "qty": 1,      // default
                  });

                  setState(() => isAddedToBag = true);
                },
                child: SizedBox(
                  height: screenHeight * 0.03,
                  width: screenWidth * 0.06,
                  child: Image.asset(
                    isAddedToBag
                        ? "assets/icons/added item.png"
                        : "assets/icons/add to cart.png",
                    color: isAddedToBag ? Colors.blue.shade400 : Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

