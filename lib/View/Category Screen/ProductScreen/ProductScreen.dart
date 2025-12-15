import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/Widgets/CategoryScreen/ProductScreen/ProductCards.dart';

import '../../../Utils/Constants/app_colors.dart';
import '../../../View Models/AccountScreen/WishlistVM.dart';
import '../../../View Models/CartListViewModel/CartListVM.dart';
import '../../../View Models/CategoryScreen/Product/Product_View_Model.dart';
import '../../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../../../Widgets/FilterBottomSheet.dart';
import '../../Account Screen/Wish List Screen/wishList.dart';
import '../../CartScreen/CartScreen.dart';
import '../../Home Screen/homescreen.dart';
import '../categoryscreen.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({super.key});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final productVM = Provider.of<ProductVM>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Homescreen()),
          );
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
                      "Products",
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
                children: [
                  Padding(
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
              //GRID
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01,
                  vertical: screenHeight * 0.01,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: productVM.products.length,
                itemBuilder: (context, index) {
                  final product = productVM.products[index];
                  return ProductCard(
                    title: product.title,
                    description: product.description,
                    image: product.image,
                    price: product.price,
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SORT BUTTON
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        height: screenHeight * 0.25,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.02,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(title: Text("Price: Low to High"),),
                            ListTile(title: Text("Price: High to Low")),
                            ListTile(title: Text("Newest First")),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.sort, color: Colors.black87),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "Sort",
                      style: GoogleFonts.getFont(
                        AppFonts.contents,
                        fontSize: screenHeight*0.018,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.065,
                width: 1,
                color: Colors.grey.shade300,
              ),
              // FILTER BUTTON
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20))),
                    builder: (_) {
                      return FilterBottomSheet();
                    },
                  );
                },

                child: Row(
                  children: [
                    Icon(Icons.filter_alt_outlined, color: Colors.black87),
                    SizedBox(width: 5),
                    Text(
                      "Filter",
                      style: GoogleFonts.getFont(
                        AppFonts.contents,
                        fontSize: screenHeight*0.018,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
