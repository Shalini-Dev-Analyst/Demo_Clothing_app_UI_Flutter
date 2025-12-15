import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../../View Models/BannerViewModel/bannercaraousalVM.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../View Models/CategoryScreen/Product/Product_View_Model.dart';
import '../../View Models/CuratedExclusivesViewModel/CuratedExclusiveVM.dart';
import '../../View Models/EliteSpotLightViewModel/EliteSpotlightVM.dart';
import '../../View Models/TodaysTopStealsViewModel/TodaysTopStealsVM.dart';
import '../../Widgets/CategoryScreen/ProductScreen/ProductCards.dart';
import '../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../../Widgets/HomeScreen/BannerCaraousalCards.dart';
import '../../Widgets/HomeScreen/CuratedEclusives.dart';
import '../../Widgets/HomeScreen/EliteSpotlight.dart';
import '../../Widgets/HomeScreen/FadeInWidget.dart';
import '../../Widgets/HomeScreen/TodaysTopSteals.dart';
import '../Account Screen/AccountScreen.dart';
import '../Account Screen/Wish List Screen/wishList.dart';
import '../CartScreen/CartScreen.dart';
import '../Category Screen/ProductScreen/ProductScreen.dart';
import '../Category Screen/categoryscreen.dart';
import '../Home Screen/homescreen.dart';

class NewDealsScreen extends StatefulWidget {
  const NewDealsScreen({super.key});

  @override
  State<NewDealsScreen> createState() => _NewDealsScreenState();
}

class _NewDealsScreenState extends State<NewDealsScreen> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Categoryscreen()),
      );
    }
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
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
    final bannersVM = BannersViewModel();
    final tvm = Provider.of<TodaystopstealsVM>(context);
    final cvm = Provider.of<CuratedexclusiveVM>(context);
    final evm = Provider.of<ElitespotlightVM>(context);
    final productVM = Provider.of<ProductVM>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                      SizedBox(width: screenWidth * 0.03),
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
                //CONTENT
                SizedBox(height: screenHeight * 0.025),
                Text("Fresh Deals",
                  style: GoogleFonts.gfsDidot(
                    color: AppColors.textField,
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.w600,
                  ),),
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
                //BANNER CAROUSAL + APP BAR
                SizedBox(height: screenHeight * 0.01),
                StaggeredSlideIn(
                  beginOffset: const Offset(0.5, 0),
                  children:[
                    Stack(
                      children: [
                        BannerCarousel(banners: bannersVM.banners),],
                    ),
                  ],
                ),
                //NEW DROPS
                SizedBox(height: screenHeight * 0.025),
                FadeInOnScroll(
                  child: Container(
                    height: screenHeight * 0.67,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:Colors.white
                      // image: DecorationImage(
                      //   image: AssetImage("assets/bgs/blue glitter.jpg"),
                      //   fit: BoxFit.cover,
                      //   colorFilter: ColorFilter.mode(
                      //     Colors.black38.withOpacity(0.3),
                      //     BlendMode.darken,
                      //   ),
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        //TITLE INSIDE CONTAINER
                        Text(
                          "New Drops",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.gfsDidot(
                            color: Color(0XFF124d86),
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        //GRID INSIDE SAME CONTAINER
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                            ),
                            child: GestureDetector(
                              onTap:(){
                                Navigator.push(context,MaterialPageRoute(builder: (_)=>Productscreen()));
                              },
                              child: Todaystopsteals(
                                TopProducts: tvm.TopProducts,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //ELITE SPOTLIGHT
                SizedBox(height: screenHeight * 0.025),
                SizedBox(height: screenHeight * 0.01),
                FadeInOnScroll(
                  child: Container(
                    height: screenHeight * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bgs/blackgold.jpg"),
                        fit: BoxFit.fill,
                        // colorFilter: ColorFilter.mode(
                        //   Colors.black.withOpacity(0.5),
                        //   BlendMode.darken,
                        // ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        //TITLE INSIDE CONTAINER
                        Text(
                          "Trending Now",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cinzel(
                            color: AppColors.containerOverlay,
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //GRID INSIDE SAME CONTAINER
                        SizedBox(height: screenHeight * 0.01),
                        Column(
                          children: [
                            Center(child: Elitespotlight(Elite: evm.Elite)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //PRODUCTS
                SizedBox(height: screenHeight * 0.03),
                FadeInOnScroll(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                      ),
                      child: Text(
                        "New Arrival Launches",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gfsDidot(
                          color: AppColors.textField,
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                FadeInOnScroll(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal:screenWidth*0.02),
                      itemCount: productVM.products.length,
                      itemBuilder: (context, index) {
                        final product = productVM.products[index];
                        return Padding(
                          padding: EdgeInsets.only(right: screenWidth*0.05),
                          child: ProductCard(
                            title: product.title,
                            description: product.description,
                            image: product.image,
                            price: product.price,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                //EDITORS PICK
                SizedBox(height: screenHeight * 0.02),
                FadeInOnScroll(
                  child: Container(
                    height: screenHeight * 0.77,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bgs/gold-removebg-preview.png"),
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(
                        //   AppColors.containerOverlay.withOpacity(0.9),
                        //   BlendMode.darken,
                        // ),
                      ),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Colors.pink.withOpacity(0.6),
                      //     Colors.blue.withOpacity(0.0),
                      //   ],
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        //TITLE
                        Text(
                          "Editor's Picks",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.gfsDidot(
                            color: AppColors.textField,
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        //GRID INSIDE SAME CONTAINER
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                            ),
                            child: Curatedeclusives(Exclusives: cvm.Exclusives),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
      //           BoxShadow(
      //             color: Colors.grey.withOpacity(0.5),
      //             blurRadius: 10,
      //             spreadRadius: 40,
      //             blurStyle: BlurStyle.normal
      //           ),
      //           // BoxShadow(
      //           //   color: Colors.red.withOpacity(0.9),
      //           //   blurRadius: 25,
      //           //   spreadRadius: 10,
      //           // ),
      //           BoxShadow(
      //             color: Colors.grey.withOpacity(0.2),
      //             blurRadius: 50,
      //             spreadRadius: 10,
      //           ),
      //         ]
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
