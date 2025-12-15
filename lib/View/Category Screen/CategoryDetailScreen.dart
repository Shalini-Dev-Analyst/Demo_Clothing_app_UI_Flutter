import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/View%20Models/CategoryScreen/CategoryScreenVM.dart';
import 'package:s_apparels_clothes/View/Category%20Screen/categoryscreen.dart';
import 'package:s_apparels_clothes/Widgets/CategoryScreen/Product/CategoryScreen.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../Account Screen/Wish List Screen/wishList.dart';
import '../CartScreen/CartScreen.dart';
import 'ProductScreen/ProductScreen.dart';

class Categorydetailscreen extends StatelessWidget {
  final String selectedCategory;

  const Categorydetailscreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final categoryVM = Provider.of<CategoryVM>(context);

    final data = selectedCategory == "Men"
        ? categoryVM.menCategories
        : selectedCategory == "Women"
        ? categoryVM.womenCategories
        : selectedCategory == "Kids"
        ? categoryVM.kidCategories
        : selectedCategory == "Traditional"
        ? categoryVM.tradCategories
        : selectedCategory == "Function"
        ? categoryVM.funCategories
        : categoryVM.genCategories;


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.push(context,MaterialPageRoute(builder: (_)=>Categoryscreen()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.05,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Categoryscreen()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.pagehead,
                        size: screenHeight * 0.025,
                      ),
                    ),
                    Text(
                      selectedCategory,
                      style: GoogleFonts.getFont(
                        AppFonts.appbar,
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.022,
                        color: AppColors.pagehead,
                      ),
                    ),
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
                    SizedBox(width: screenWidth * 0.05),
                    // Cart Icon with counter
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Cartscreen()),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                              "assets/icons/cart.png",
                              height: screenHeight * 0.03,
                              color:AppColors.pagehead
                          ),
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Consumer<Cartlistviewmodel>(
                              builder: (context, cartVM, child) {
                                if (cartVM.cart.isEmpty) return const SizedBox();
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
                                    '${cartVM.cart.length}',
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
                    height: screenHeight * 0.17,
                    width: screenWidth * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/banners/banner/banner2 (1).jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ],
              ),
              //LIST
              ...data.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //CATEGORY TOPIC TITLE
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.04,
                        screenHeight * 0.015,
                        screenWidth * 0.04,
                        screenHeight * 0.01,
                      ),
      
                      child: Text(
                        entry.key,
                        style: GoogleFonts.gfsDidot(
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pagesubtext,
                        ),
                      ),
                    ),
                    //GRID WIDGET
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder:(_)=>Productscreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: CategoryScreen(Categories: entry.value),
                      ),
                    ),
                  ],
                );
              }).toList(),
              SizedBox(height:screenHeight*0.02),
            ],
          ),
        ),
      ),
    );
  }
}
