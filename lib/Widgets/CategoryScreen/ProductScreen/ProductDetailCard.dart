import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';

import '../../../Utils/Constants/app_fonts.dart';
import '../../../View Models/AccountScreen/WishlistVM.dart';
import '../../../View Models/CartListViewModel/CartListVM.dart';

class ProductDetailScreenCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String price;
  // NEW CALLBACKS
  final Function(int qty)? onQuantityChanged;
  final Function(String size)? onSizeChanged;
  const ProductDetailScreenCard({super.key,  required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.onQuantityChanged,
    this.onSizeChanged,});

  @override
  State<ProductDetailScreenCard> createState() => _ProductDetailScreenCardState();
}

class _ProductDetailScreenCardState extends State<ProductDetailScreenCard> {
  bool isWishlisted = false;
  bool isAddedToCart = false;
  int quantity = 1;
  String selectedSize = "M";
  String selectedcolors = "Beige";

  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  final List<String> colors = ["Red", "Blue", "Green", "Beige", "Brown"];
  bool isAddedToBag = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cartVM = Provider.of<Cartlistviewmodel>(context);

    isAddedToBag = cartVM.cart.any((item) => item["name"] == widget.title);
  }

  @override
  Widget build(BuildContext context) {
  final screenheight= MediaQuery.of(context).size.height;
  final screenwidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //PRODUCT IMAGE
        Stack(
          children: [
            Container(
              height:screenheight*0.5,
              width:screenwidth*1,
              decoration:BoxDecoration(
                color:Colors.transparent,
                  image:DecorationImage(image:AssetImage(widget.image),
                      fit:BoxFit.cover)
              ),
            ),
            Positioned(
              right:screenwidth*0.039,
              top: screenheight*0.012,
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
                  height: screenheight * 0.025,
                  color: Colors.pink,
                ),
              ),
            )
          ],
        ),
        //PRODUCT NAME
        SizedBox(height: screenheight*0.02),
        Padding(
          padding:EdgeInsets.symmetric(horizontal:screenwidth*0.04),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(widget.title,
                style: GoogleFonts.gfsDidot(
                  fontSize: screenheight* 0.024,
                  fontWeight: FontWeight.w700,
                  color: AppColors.pagehead
                ),),
              GestureDetector(
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
                  height: screenheight * 0.03,
                  width: screenwidth * 0.06,
                  child: Image.asset(
                    isAddedToBag
                        ? "assets/icons/added item.png"
                        : "assets/icons/add to cart.png",
                    color: isAddedToBag ? Colors.blue.shade400 : Colors.red,
                  ),
                ),
              ),

            ],
          ),
        ),
        //PRODUCT DETAILS
        SizedBox(height: screenheight*0.01),
        Padding(
          padding:EdgeInsets.symmetric(horizontal:screenwidth*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Details",
                style: GoogleFonts.gfsDidot(
                  fontSize: screenheight* 0.02,
                  fontWeight: FontWeight.w600,
                ),),
              SizedBox(height:screenheight*0.01),
              Container(
                height:screenheight*0.1,
                width: screenwidth*0.9,
                child: Text(widget.description,
                  style: GoogleFonts.getFont(
                    AppFonts.body,
                    fontSize: screenheight* 0.014,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign:TextAlign.justify,),
              ),
            ],
          ),
        ),
        // SIZE SELECT CELLS
        SizedBox(height: screenheight*0.005),
        Padding(
          padding:EdgeInsets.symmetric(horizontal:screenwidth*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Size",
                style: GoogleFonts.gfsDidot(
                  fontSize: screenheight* 0.02,
                  fontWeight: FontWeight.w600,
                ),),
              SizedBox(height: screenheight*0.01),
              Wrap(
                spacing: screenwidth * 0.02,
                runSpacing: screenheight * 0.01,
                children: sizes.map((s) {
                  final bool isSelected = selectedSize == s;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedSize = s);
                      widget.onSizeChanged?.call(selectedSize);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenwidth * 0.035,
                        vertical: screenheight * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        s,
                        style: GoogleFonts.getFont(
                          AppFonts.title,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.black : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        //COLOR SELECTION
        SizedBox(height: screenheight*0.02),
        Padding(
          padding:EdgeInsets.symmetric(horizontal:screenwidth*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Color",
                style: GoogleFonts.gfsDidot(
                  fontSize: screenheight* 0.02,
                  fontWeight: FontWeight.w600,
                ),),
              SizedBox(height: screenheight*0.01),
              Wrap(
                spacing: screenwidth * 0.02,
                runSpacing: screenheight * 0.01,
                children: colors.map((c) {
                  final bool isSelected = selectedcolors == c;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedcolors = c);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenwidth * 0.035,
                        vertical: screenheight * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ?Colors.transparent : Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        c,
                        style: GoogleFonts.getFont(
                          AppFonts.title,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.black : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        // QUANTITY BUTTONS
        SizedBox(height: screenheight*0.03),
        Padding(
          padding:EdgeInsets.symmetric(horizontal:screenwidth*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Quantity",
                style: GoogleFonts.gfsDidot(
                  fontSize: screenheight* 0.02,
                  fontWeight: FontWeight.w600,
                ),),
              SizedBox(height: screenheight*0.01),
              Container(
                alignment: Alignment.center,
                height:screenheight*0.04,
                width:screenwidth*0.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:Border.all(color: Color(0XFF124d86),
                  width:2)
                ),
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal:screenwidth*0.02,vertical:screenheight*0.005),
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                            widget.onQuantityChanged?.call(quantity);
                          }
                        },
                        child: Icon(Icons.remove,color: Colors.black,),
                      ),
                      SizedBox(width:screenwidth*0.03),
                      Text(quantity.toString(),style:GoogleFonts.getFont(
                        AppFonts.title,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: screenheight*0.014
                      ),),
                      SizedBox(width:screenwidth*0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() => quantity++);
                          widget.onQuantityChanged?.call(quantity);
                        },
                        child: Icon(Icons.add,color: Colors.black,),
                      ),
                    ],
                  )
                  ,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenheight*0.03),
      ],
    );
  }
}
