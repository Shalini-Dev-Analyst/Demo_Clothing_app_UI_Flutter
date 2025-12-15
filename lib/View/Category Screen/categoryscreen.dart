import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';
import 'package:s_apparels_clothes/View/Home%20Screen/homescreen.dart';
import '../../Utils/Constants/app_fonts.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../Widgets/CategoryScreen/CategoryBox.dart';
import '../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../Account Screen/AccountScreen.dart';
import '../Account Screen/Wish List Screen/wishList.dart';
import '../CartScreen/CartScreen.dart';
import '../Top Deals Screen/topdeals.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewDealsScreen()),
      );
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accountscreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Homescreen()));
        }
      },
      child: Scaffold(
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
          child:Column(
            children: [
              Padding(
                padding:EdgeInsets.only(left:screenWidth*0.04,right:screenWidth*0.04,top: screenHeight*0.05),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>Homescreen()));
                      },
                        child: Icon(Icons.arrow_back_ios,color:AppColors.pagehead,size:screenHeight*0.025)),
                    Image.asset("assets/logo/Logo-02.png",height:screenHeight*0.035),
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
              // Padding(
              //   padding:EdgeInsets.symmetric(horizontal:screenWidth*0.04),
              //   child: Productbannercaraousal(productbanners: bannersVM.productbanners),
              // ),
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
              Categorybox(),
              SizedBox(height: screenHeight * 0.09),
            ],
          )
        ),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            backgroundColor:Colors.white,
            elevation: 4,
            type: BottomNavigationBarType.fixed,
            iconSize:screenHeight*0.5,
            unselectedFontSize: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: AppColors.pagehead,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedLabelStyle: GoogleFonts.getFont(
              AppFonts.contents,
              color: Colors.grey.shade600,
              fontSize: screenHeight * 0.012,
              fontWeight: FontWeight.w500,
            ),
            items: [
              BottomNavigationBarItem(
                icon: _glowIcon("assets/icons/home.png", 0),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: _glowIcon("assets/icons/categories.png", 1),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: _glowIcon("assets/icons/new.png", 2),
                label: "New",
              ),
              BottomNavigationBarItem(
                icon: _glowIcon("assets/icons/profile.png", 3),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
  //GLOW ANIMATION FOR ICON
  Widget _glowIcon(String asset, int index) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool isActive = _selectedIndex == index;

    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.all(isActive ? 1 : 1),
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   boxShadow: isActive
      //       ? [
      //     BoxShadow(
      //         color: Colors.grey.withOpacity(0.5),
      //         blurRadius: 10,
      //         spreadRadius: 40,
      //         blurStyle: BlurStyle.normal
      //     ),
      //     // BoxShadow(
      //     //   color: Colors.red.withOpacity(0.9),
      //     //   blurRadius: 25,
      //     //   spreadRadius: 10,
      //     // ),
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.2),
      //       blurRadius: 50,
      //       spreadRadius: 10,
      //     ),
      //   ]
      //       : [],
      // ),
      child: Image.asset(
        asset,
        height:screenHeight*0.03,
        width:screenWidth*0.08,
        color: isActive ? Color(0XFFd93932) : Color(0XFF124d86),
      ),
    );
  }
}
