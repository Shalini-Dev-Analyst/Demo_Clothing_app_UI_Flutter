import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/View/CartScreen/AddressScreen.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../Widgets/CartScreen/CartItems.dart';
import '../../Widgets/CartScreen/CheckOutStepper.dart';
import '../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../Account Screen/Wish List Screen/wishList.dart';
import '../Home Screen/homescreen.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Consumer<Cartlistviewmodel>(
          builder: (context, cartVM, _) {
            return Container(
              padding: EdgeInsets.only(
                left: screenWidth * 0.07,
                right: screenWidth * 0.07,
                top: screenHeight * 0.01,
                bottom: screenHeight * 0.025,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MRP: ₹${cartVM.getTotalPrice().toStringAsFixed(2)}\n(Incl. All Taxes)",
                    style: GoogleFonts.getFont(
                      AppFonts.body,
                      fontSize: screenHeight * 0.018,
                      fontWeight: FontWeight.w500,
                      color:Colors.grey.shade700,
                    ),
                  ),
                  GestureDetector(
                    onTap: cartVM.cart.isEmpty
                        ? null
                        : () {
                      Navigator.push(context, MaterialPageRoute(builder:(_)=>AddressScreen()));
                    },
                    child: Container(
                      height: screenHeight * 0.04,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                        color: cartVM.cart.isEmpty
                            ? Colors.grey.shade400
                            : AppColors.pagesubtext,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Place Order",
                        style: GoogleFonts.getFont(
                          AppFonts.title,
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.w600,
                          color: cartVM.cart.isEmpty
                              ? Colors.grey.shade200
                              : AppColors.containerOverlay,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              //HEADER
              Padding(
                padding:EdgeInsets.only(left:screenWidth*0.04,right:screenWidth*0.04,top: screenHeight*0.05),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_)=>Homescreen()));
                        },
                        child: Icon(Icons.arrow_back_ios,color:AppColors.pagehead,size:screenHeight*0.025)),
                    Text("Shopping Bag",
                        style:GoogleFonts.getFont(
                            AppFonts.appbar,
                            fontWeight:FontWeight.w500,
                            fontSize: screenHeight*0.025,
                            color:AppColors.pagehead
                        )),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => WishlistScreen()),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            "assets/icons/wishlist heart white.png",
                            height: screenHeight * 0.03,
                            color:AppColors.pagehead,
                          ),
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Consumer<WishlistVM>(
                              builder: (context, wishlistVM, child) {
                                if (wishlistVM.wishlist.isEmpty) return const SizedBox();
                                return Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${wishlistVM.wishlist.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //OFFER BANNER
              SizedBox(height: screenHeight * 0.025),
              StaggeredSlideIn(
                beginOffset: Offset(-0.6, 0),
                children: [Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                  ),
                  child: Container(
                    height: screenHeight * 0.15,
                    width: screenWidth * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/banners/banner/banner (1).jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ],
              ),
              //CHECKOUT STEPPER
              Consumer<Cartlistviewmodel>(
                builder: (context, cartVM, _) {
                  if (cartVM.cart.isEmpty) {
                    return SizedBox();
                  }
                  return Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      CheckoutStepper(currentStep: 0),
                    ],
                  );
                },
              ),
              //APPLY COUPONS
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Apply Coupon",
                          labelStyle: GoogleFonts.getFont(
                              AppFonts.contents,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.014,
                              color:Colors.grey.shade700
                          ),
                          hintText: "Enter Coupon Code",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: AppColors.textField),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: AppColors.textField),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width:screenWidth*0.02,),
                    GestureDetector(
                      child:Container(
                        height:screenHeight*0.05,
                        width:screenWidth*0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.grey.shade300,
                        ),
                        alignment: Alignment.center,
                        child:Text("Apply",
                          textAlign: TextAlign.center,
                          style:GoogleFonts.getFont(
                            AppFonts.title,
                            fontWeight: FontWeight.w600,
                            fontSize: screenHeight * 0.018,
                            color: AppColors.textFieldHint
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              // CART ITEMS
              Padding(
                padding: EdgeInsets.symmetric(vertical:screenHeight*0.03),
                child: Consumer<Cartlistviewmodel>(
                  builder: (context, cartVM, child) {
                    if (cartVM.cart.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          "Your cart is empty",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: screenHeight * 0.02,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Column(
                        children: List.generate(cartVM.cart.length, (index) {
                          final item = cartVM.cart[index];

                          return Cartitems(
                            img: item["img"],
                            name: item["name"],
                            price: item["price"],
                            size: item["size"],
                            qty: item["qty"],

                            // DELETE ITEM
                            onDelete: () {
                              cartVM.removeItemByName(item["name"]);
                            },
                            // UPDATE SIZE + QTY
                            onUpdate: (newSize, newQty) {
                              cartVM.updateCartItem(item["name"], newSize, newQty);
                            },
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
