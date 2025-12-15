import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/View%20Models/CategoryScreen/Product/Product_View_Model.dart';
import 'package:s_apparels_clothes/View%20Models/EliteSpotLightViewModel/EliteSpotlightVM.dart';
import 'package:s_apparels_clothes/View%20Models/TodaysTopStealsViewModel/TodaysTopStealsVM.dart';
import 'package:s_apparels_clothes/View%20Models/UniqueCollectionsViewModel/UniqueCollectionsCardsVM.dart';
import 'package:s_apparels_clothes/View%20Models/WinterSpotViewModel/WinterSpotVM.dart';
import 'package:s_apparels_clothes/View/Account%20Screen/AccountScreen.dart';
import 'package:s_apparels_clothes/View/Account%20Screen/Wish%20List%20Screen/wishList.dart';
import 'package:s_apparels_clothes/View/CartScreen/CartScreen.dart';
import 'package:s_apparels_clothes/View/Category%20Screen/ProductScreen/ProductScreen.dart';
import 'package:s_apparels_clothes/View/Category%20Screen/categoryscreen.dart';
import 'package:s_apparels_clothes/View/Initial%20Screen/initialscreen.dart';
import 'package:s_apparels_clothes/View/Top%20Deals%20Screen/topdeals.dart';
import 'package:s_apparels_clothes/Widgets/CategoryScreen/StaggeredSlideIn.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/CuratedEclusives.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/EliteSpotlight.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/FadeInWidget.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/PriceDropParadise.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/SignatureBrandsLogo.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/TodaysTopSteals.dart';
import 'package:s_apparels_clothes/Widgets/HomeScreen/UniqueCollectionsCards.dart';
import '../../Models/Profile/Profile_data.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../../View Models/BannerViewModel/bannercaraousalVM.dart';
import '../../View Models/BrandsOfferCardViewModel/BrandOffersVM.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../View Models/CuratedExclusivesViewModel/CuratedExclusiveVM.dart';
import '../../View Models/PartyReadyViewModel/PartyReadyVM.dart';
import '../../View Models/PriceDropParadiseViewModel/PriceDropParaDiseVM.dart';
import '../../View Models/SeasonalCardsViewModel/SeasonalCaraousalVM.dart';
import '../../View Models/SignatureBrandsViewModel/SignatureBrandsVM.dart';
import '../../View Models/WeddingDairiesViewModel/WeddingDiariesVM.dart';
import '../../Widgets/CategoryScreen/ProductScreen/ProductCards.dart';
import '../../Widgets/HomeScreen/BannerCaraousalCards.dart';
import '../../Widgets/HomeScreen/BrandsOfferCard.dart';
import '../../Widgets/HomeScreen/PrtyWears.dart';
import '../../Widgets/HomeScreen/SeasonalCaraousalCards.dart';
import '../../Widgets/HomeScreen/WeddingDiaries.dart';
import '../../Widgets/HomeScreen/WinterSpot.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String locationFull = 'Fetching...';
  bool locationFetched = false;
  final bannersVM = BannersViewModel();
  List<dynamic> searchResults = [];
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
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
  void initState() {
    super.initState();
    //LOCATION FETCH
    _fetchLocation();
    ProfileData.loadUserData();
    //SEARCH LISTENER
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          searchResults = [];
          isLoading = false;
        });
      } else {
        null;
      }
    });
  }

  ///FUNCTIONS USED
  //FETCHING LOCATION
  Future<void> _fetchLocation() async {
    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationFull = 'Permission denied';
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          locationFull = 'Permission denied forever';
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          locationFull =
          "${p.subLocality ?? p.locality ?? ''} - ${p.postalCode ?? ''}";
          locationFetched = true;
        });
      } else {
        setState(() {
          locationFull = "Unknown address";
        });
      }
    } catch (e) {
      setState(() {
        locationFull = "Error fetching address";
      });
    }
  }

  //FETCHING CURRENT ADDRESS
  Future<String> getCurrentAddress() async {
    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return "Permission denied";
      }
      if (permission == LocationPermission.deniedForever) {
        return "Permission denied forever";
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return "${placemark.subLocality ?? placemark.locality ?? ''} - ${placemark.postalCode ?? ''}";
      }

      return "Unknown location";
    } catch (e) {
      return "Error Fetching Location";
    }
  }

  //FETCHING FULL ADDRESS
  Future<String> getFullAddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        // Format: street, subLocality, locality, postalCode
        return "${p.subLocality ?? p.locality ?? ''} - ${p.postalCode ?? ''}";
      }

      return "Unknown address";
    } catch (e) {
      return "Error fetching address";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final svm = Provider.of<SeasonalCardsViewModel>(context);
    final tvm = Provider.of<TodaystopstealsVM>(context);
    final wvm = Provider.of<Winterspotvm>(context);
    final cvm = Provider.of<CuratedexclusiveVM>(context);
    final pvm = Provider.of<PricedropparadiseVM>(context);
    final pyvm = Provider.of<PartyreadyVM>(context);
    final evm = Provider.of<ElitespotlightVM>(context);
    final productVM = Provider.of<ProductVM>(context);
    final logo = Signaturebrandsvm().logos;
    final collections = UniquecollectionscardsVm().Collections;
    final Dairies = WeddingdiariesVM().Wedding;
    final bannersVM = BannersViewModel();
    final brandData = BrandOfferCardsvm().BrandOffers;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //BG IMAGE
            Positioned.fill(
              top:screenHeight*0.09,
              child: Image.asset("assets/bgs/bgg-removebg-preview.png", 
                fit: BoxFit.cover,
                color:Color(0XFFEFF5FC).withOpacity(0.6),),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  //LEFT LOCATION BAR
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.04),
                    child: FutureBuilder<String>(
                      future: Future.value(locationFull),
                      builder: (context, snapshot) {
                        return Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        size: screenHeight * 0.02,
                                        color:Colors.black87,
                                      ),
                                      SizedBox(width: screenWidth * 0.015),
                                      Text(
                                        "Delivery:",
                                        style: GoogleFonts.getFont(
                                          AppFonts.appbar,
                                          fontWeight: FontWeight.w700,
                                          fontSize: screenHeight * 0.016,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Flexible(
                                        child: Text(
                                          locationFull,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.getFont(
                                            AppFonts.body,
                                            fontWeight: FontWeight.w500,
                                            fontSize: screenHeight * 0.016,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                  ),
                                  child: Image.asset("assets/logo/Logo-02.png",height:screenHeight*0.04,),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //BANNER CAROUSAL + APP BAR
                  SizedBox(height: screenHeight * 0.01),
                  StaggeredSlideIn(
                    beginOffset:Offset(0.5, 0),
                    children: [
                      Stack(
                        children: [
                          BannerCarousel(banners: bannersVM.banners),
                          Positioned(
                            top: screenHeight * 0.001,
                            child: Container(
                              height: screenHeight * 0.05,
                              width: screenWidth * 1,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenHeight * 0.005,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,MaterialPageRoute(builder: (_)=>Accountscreen()));
                                            },
                                          child: Icon(Icons.account_circle_sharp,size:screenHeight*0.04,color:Colors.white,)
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            // Show confirmation dialog
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  title: Row(
                                                    children: const [
                                                      Icon(Icons.logout, color: Colors.red),
                                                      SizedBox(width: 8),
                                                      Text("Confirm Logout"),
                                                    ],
                                                  ),
                                                  content: const Text("Are you sure you want to log out?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(color: Colors.grey),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        await ProfileData.logout();
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) => Initialscreen(),
                                                          ),
                                                        );
                                                      },
                                                      child:Text(
                                                        "Logout",
                                                        style: GoogleFonts.getFont(
                                                          AppFonts.body,
                                                          color: Colors.red,
                                                          fontSize: screenHeight * 0.020,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child:Image.asset("assets/icons/ri--logout-circle-r-line.png",height:screenHeight*0.035,),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SEARCH BAR
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal:screenWidth*0.04),
                    child: Row(
                      children: [
                        Container(
                          height: screenHeight * 0.04,
                          width: screenWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0XFFFCFCFC),
                            border: Border.all(color: AppColors.textField),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "      Search Products or...",
                              hintStyle: GoogleFonts.getFont(
                                AppFonts.body,
                                color: Color(0XFF8D8D8D),
                                fontWeight: FontWeight.w500,
                                fontSize: screenHeight * 0.018,
                              ),
                              // Use prefixIcon instead of prefix
                              // prefixIcon: Padding(
                              //   padding: EdgeInsets.only(
                              //     left: screenWidth * 0.03,
                              //     right: screenWidth * 0.05,
                              //     top: screenHeight * 0.005,
                              //     bottom: screenHeight * 0.005,
                              //   ),
                              //   child: Image.asset(
                              //     "assets/logo/Logo-02.png",
                              //     fit: BoxFit.contain,
                              //   ),
                              // ),
                              // prefixIconConstraints: BoxConstraints(
                              //   minWidth: screenHeight * 0.03,
                              //   minHeight: screenHeight * 0.03,
                              // ),
                              suffixIcon: Icon(
                                Icons.search_outlined,
                                size: screenHeight * 0.03,
                                color: const Color(0xFF002B5B),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 0,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
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
                                    height: screenHeight * 0.032,
                                    color:Colors.black,
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
                            SizedBox(width: screenWidth * 0.04),
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
                                    height: screenHeight * 0.032,
                                    color:Colors.black,
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
                        )
                      ],
                    ),
                  ),
                  //TODAYS TOP STEALS
                  SizedBox(height: screenHeight * 0.01),
                  FadeInOnScroll(
                    child: Stack(
                      children: [
                        //REAL CONTENT
                        Container(
                          height: screenHeight * 0.65,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color:Color(0XFFd93932),
                            color:Colors.white
                            // image: DecorationImage(
                            //   image: AssetImage("assets/bgs/brandofferbg.jpg"),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                "Today's Top Steals",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.gfsDidot(
                                  color:Color(0XFF9C0005),
                                  fontSize: screenHeight * 0.03,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => Productscreen()),
                                      );
                                    },
                                    child: Todaystopsteals(TopProducts: tvm.TopProducts),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // //OVERLAY TOP
                        // Positioned(
                        //   top: 0,
                        //   left: 0,
                        //   right: 0,
                        //   height: screenHeight * 0.15,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Colors.pink.withOpacity(0.7),
                        //           Colors.transparent,
                        //         ],
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // //OVERLAY BOTTOM
                        // Positioned(
                        //   bottom: 0,
                        //   left: 0,
                        //   right: 0,
                        //   height: screenHeight * 0.05,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Colors.transparent,
                        //           Colors.pink.withOpacity(0.7),
                        //         ],
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  //LIMITED TIME LUXE
                  SizedBox(height: screenHeight * 0.01),
                  FadeInOnScroll(
                    child: Stack(
                      children:[
                        Container(
                          height: screenHeight * 0.28,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Colors.transparent,
                            // image: DecorationImage(
                            //   image: AssetImage("assets/bgs/offerend.jpg"),
                            //   fit: BoxFit.cover,
                            //   colorFilter: ColorFilter.mode(
                            //     Colors.black.withOpacity(0.5),
                            //     BlendMode.darken,
                            //   ),
                            // ),
                          ),
                          child: Stack(
                            children: [
                              //TOP CENTER TEXT INSIDE THE CONTAINER
                              Positioned(
                                top: screenHeight * 0.01,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "Limited Time Luxe",
                                    style: GoogleFonts.gfsDidot(
                                      color:Color(0XFF124D86),
                                      fontSize: screenHeight * 0.03,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              //HORIZONTAL SLIDER BELOW THE TEXT
                              Positioned(
                                top: screenHeight * 0.06,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => NewDealsScreen()),
                                      );
                                    },
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: brandData.length,
                                      itemBuilder: (context, index) {
                                        final p = brandData[index];
                                        return Brandsoffercard(img: p["img"]);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // //OVERLAY TOP
                        // Positioned(
                        //   top: 0,
                        //   left:screenWidth*0,
                        //   right: 0,
                        //   height: screenHeight * 0.15,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Colors.blue.withOpacity(0.1),
                        //           Colors.transparent,
                        //         ],
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomLeft,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  FadeInOnScroll(
                    child: Stack(
                      children:[
                        Container(
                          height: screenHeight * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            // image: DecorationImage(
                            //   image: AssetImage("assets/bgs/3dc82cf853befdf23ff87531f22bb89d.jpg"),
                            //   fit: BoxFit.fill,
                            //   // colorFilter: ColorFilter.mode(
                            //   //   Colors.black.withOpacity(0.5), // OPACITY HERE
                            //   //   BlendMode.darken,
                            //   // ),
                            //),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child:GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => NewDealsScreen()),
                                );
                              },
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: brandData.length,
                                itemBuilder: (context, index) {
                                  final p = brandData[index];
                                  return Brandsoffercard(img: p["img"]);
                                },
                              ),
                            ),
                          ),
                        ),
                        // //OVERLAY BOTTOM
                        // Positioned(
                        //   bottom: 0,
                        //   left: 0,
                        //   right:screenWidth*0,
                        //   height: screenHeight * 0.15,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         colors: [
                        //           Colors.transparent,
                        //           Colors.blue.withOpacity(0.1),
                        //         ],
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomLeft,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  //CURATED EXCLUSIVES
                  SizedBox(height: screenHeight * 0.02),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.67,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:Color(0XFFF9F8F6).withOpacity(0.8)
                        // image: DecorationImage(
                        //   image: AssetImage("assets/bgs/pinkgold.jpg"),
                        //   fit: BoxFit.fill,
                        //   // colorFilter: ColorFilter.mode(
                        //   //   AppColors.textField.withOpacity(0.2),
                        //   //   BlendMode.darken,
                        //   // ),
                        // ),
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
                          SizedBox(height: screenHeight * 0.02),
                          //TITLE
                          Text(
                            "Curated Exclusives",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gfsDidot(
                              color: AppColors.textField,
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          //GRID INSIDE SAME CONTAINER
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => Productscreen()),
                                    );
                                  },
                                  child: Curatedeclusives(Exclusives: cvm.Exclusives)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //WINTER SPOTS
                  SizedBox(height: screenHeight * 0.02),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.7,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/winter-landscape_1048-38(1).jpg"),
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(
                          //   Colors.black.withOpacity(0.2),
                          //   BlendMode.darken,
                          // ),
                        ),
                          //color:Color(0XFFFBFBFB)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          //TITLE INSIDE CONTAINER
                          Text(
                            "Autumn Winter'25",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gfsDidot(
                              color: Color(0XFF124d86),
                              fontSize: screenHeight * 0.027,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Center(
                            child: Container(
                              height: screenHeight * 0.2,
                              width: screenWidth * 1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/placeholders/products/couples.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.045),
                          //GRID INSIDE SAME CONTAINER
                          Column(
                            children: [
                              Text(
                                "Beat the winter freeze with fashion built to move",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.gfsDidot(
                                  color: Color(0XFF010169),
                                  fontSize: screenHeight * 0.018,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 10,
                                      color: Colors.blue.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => Productscreen()),
                                    );
                                  },
                                  child: Winterspot(season: wvm.season))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //PRICE DROP PARADISE
                  SizedBox(height: screenHeight * 0.01),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.7,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/bg1.jpg"),
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
                          SizedBox(height: screenHeight * 0.06),
                          //TITLE INSIDE CONTAINER
                          Text(
                            "Price Drop Paradise",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gfsDidot(
                              color: AppColors.containerOverlay,
                              fontSize: screenHeight * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          //GRID INSIDE SAME CONTAINER
                          SizedBox(height: screenHeight * 0.02),
                          Column(
                            children: [
                              Text(
                                "Your wallet’s happy place",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  AppFonts.body,
                                  color: Colors.white,
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => Productscreen()),
                                      );
                                    },
                                    child: Pricedropparadise(Brands: pvm.Brands)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SIGNATURE BRANDS
                  SizedBox(height: screenHeight * 0.04),
                  FadeInOnScroll(
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // image: DecorationImage(
                        //   image: AssetImage("assets/bgs/signature brands.jpg"),
                        //   fit: BoxFit.cover,
                        //   colorFilter: ColorFilter.mode(
                        //     Colors.white.withOpacity(0.9),
                        //     BlendMode.darken,
                        //   ),
                        // ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.015),
                          //TITLE INSIDE THE CONTAINER
                          Text(
                            "Signature Brands",
                            style: GoogleFonts.gfsDidot(
                              color:AppColors.textField,
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          //INSIDE BANNER WITH QUOTE
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // image: DecorationImage(
                              //   image: AssetImage("assets/bgs/flexbanner3.jpg"),
                              //   fit: BoxFit.fill,
                              //   colorFilter: ColorFilter.mode(
                              //     AppColors.containerOverlay.withOpacity(0.7),
                              //     BlendMode.colorBurn,
                              //   ),
                              // ),

                            ),
                            child: Center(
                              child: Text(
                                "Designed for those who define their own class.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  AppFonts.body,
                                  color:Colors.grey.shade700,
                                  fontSize: screenHeight * 0.016,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          //LOGO SLIDER INSIDE THE SAME CONTAINER
                          SizedBox(
                            height: screenHeight * 0.13,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: logo.length,
                              itemBuilder: (context, index) {
                                final p = logo[index];
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => NewDealsScreen()),
                                      );
                                    },
                                    child: Signaturebrandslogo(img: p["img"]));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //OFFER BANNER
                  SizedBox(height: screenHeight * 0.025),
                  StaggeredSlideIn(
                    beginOffset: Offset(-0.6, 0),
                    children: [
                      Container(
                        height: screenHeight * 0.1,
                        width: screenWidth * 1,
                        decoration: BoxDecoration(
                            shape:BoxShape.rectangle,
                            image: DecorationImage(image: AssetImage("assets/banners/banner/banner2 (1).jpg"),fit:BoxFit.fitWidth)
                        ),
                      ),
                    ],
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
                          "Start To\nExplore Now Our New Launches",
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
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.04,
                          top:screenHeight*0.02,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productVM.products.length,
                          itemBuilder: (context, index) {
                            final product = productVM.products[index];
                            return Padding(
                              padding: EdgeInsets.only(right: screenWidth * 0.05),
                              child: SizedBox(
                                width: screenWidth * 0.5,
                                child: ProductCard(
                                  title: product.title,
                                  description: product.description,
                                  image: product.image,
                                  price: product.price,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  //BANNER QUOTES
                  SizedBox(height: screenHeight * 0.05),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/blackgold.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Premium Picks for The Worthy.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gfsDidot(
                              color: Colors.white,
                              fontSize: screenHeight * 0.023,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //UNIQUE COLLECTIONS
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.7,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/pre.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          //TITLE INSIDE CONTAINER
                          Text(
                            "Premium Picks",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gfsDidot(
                              color: Colors.white,
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          //GRID INSIDE SAME CONTAINER
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => NewDealsScreen()),
                                  );
                                },
                                child: Uniquecollectionscards(
                                  Collections: collections,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //WEDDING DIARIES
                  SizedBox(height: screenHeight * 0.02),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.7,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/mrg.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          //BG IMAGE
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: screenHeight * 0.3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.textField.withOpacity(0.6),
                                    AppColors.textField.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: screenHeight * 0.3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.textField.withOpacity(0.6),
                                    AppColors.textField.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              //TITLE
                              SizedBox(height: screenHeight * 0.1),
                              Text(
                                "Wedding Diaries\nShaadi Waale",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cinzel(
                                  color: AppColors.textField,
                                  fontSize: screenHeight * 0.03,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.045),
                              //HORIZONTAL SCROLLER HERE
                              SizedBox(
                                height: screenHeight * 0.4,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => Productscreen()),
                                      );
                                    },
                                    child: Weddingdiaries(Wedding: Dairies)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //STEALS OF THE SEASON
                  SizedBox(height: screenHeight * 0.03),
                  FadeInOnScroll(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                        ),
                        child: Text(
                          "Steals Of The Season",
                          style: GoogleFonts.gfsDidot(
                            color: AppColors.submitButton,
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.03,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow:
                        [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 60,
                            spreadRadius: 16,
                          ),
                          // BoxShadow(
                          //   color: Colors.red.withOpacity(0.9),
                          //   blurRadius: 25,
                          //   spreadRadius: 10,
                          // ),
                          BoxShadow(
                            color: Colors.red.withOpacity(0.2),
                            blurRadius: 90,
                            spreadRadius: 16,
                          ),
                        ],),
                      child: Center(
                        child: Text(
                          "Your wardrobe,ready for any moment",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            AppFonts.body,
                            color: AppColors.textField,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w400,

                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.55,
                      width: screenWidth * 1,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.04,
                          right: screenWidth * 0.04,
                          top: screenHeight * 0.01,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Productscreen()),
                              );
                            },
                            child: Seasonalcaraousalcards(banners: svm.seasons)),
                      ),
                    ),
                  ),
                  //PARTY READY
                  SizedBox(height: screenHeight * 0.01),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/party.jpg"),
                          fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(
                          //   Colors.black.withOpacity(0.5),
                          //   BlendMode.darken,
                          // ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          //TITLE INSIDE CONTAINER
                          Text(
                            "Party Ready",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.gfsDidot(
                              color: Colors.white,
                              fontSize: screenHeight * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          //GRID INSIDE SAME CONTAINER
                          SizedBox(height: screenHeight * 0.04),
                          Consumer<PartyreadyVM>(
                            builder: (context, vm, _) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => Productscreen()),
                                    );
                                  },
                                  child: Partywears(Party: pyvm.Party));
                            },
                          ),
                          //MAIN IMAGE
                          SizedBox(height: screenHeight * 0.02),
                          Image.asset(
                            "assets/placeholders/products/partys.jpg",
                            fit: BoxFit.cover,
                            height: screenHeight * 0.5,
                            width: screenWidth * 0.65,
                          ),
                          //SHOP NOW
                          SizedBox(height: screenHeight * 0.01),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Productscreen()),
                              );
                            },
                            child: Container(
                              height: screenHeight * 0.05,
                              width: screenWidth * 0.5,
                              decoration: BoxDecoration(
                                color: AppColors.containerOverlay,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "SHOP NOW",
                                  style: GoogleFonts.cinzel(
                                    color: AppColors.textField,
                                    fontWeight: FontWeight.w800,
                                    fontSize: screenHeight * 0.022,
                                  ),
                                ),
                              ),
                            ),
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
                          "Shop Now Unlimited",
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.04,
                        top:screenHeight*0.02,
                        bottom:screenHeight*0.02
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productVM.products.length,
                          itemBuilder: (context, index) {
                            final product = productVM.products[index];
                            return Padding(
                              padding: EdgeInsets.only(right: screenWidth * 0.05),
                              child: SizedBox(
                                width: screenWidth * 0.5,
                                child: ProductCard(
                                  title: product.title,
                                  description: product.description,
                                  image: product.image,
                                  price: product.price,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  //ELITE SPOTLIGHT
                  SizedBox(height: screenHeight * 0.01),
                  FadeInOnScroll(
                    child: Container(
                      height: screenHeight * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgs/bluebg.jpg"),
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
                            "Elite Spotlight",
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
                              Center(child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => Productscreen()),
                                    );
                                  },
                                  child: Elitespotlight(Elite: evm.Elite))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // extendBody: true, // needed to show FAB over the bottom bar
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     // Action for FAB
            //   },
            //   backgroundColor: Colors.blue,
            //   child: Icon(Icons.add),
            // ),
            //BOTTOM NAVIGATION BAR
            // bottomNavigationBar: ClipRRect(
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(40),
            //     topRight: Radius.circular(40),
            //   ),
            //   child: SizedBox(
            //     height: screenHeight * 0.1,
            //     child: BottomNavigationBar(
            //       backgroundColor: Colors.white70,
            //       currentIndex: _selectedIndex,
            //       type: BottomNavigationBarType.fixed,
            //       onTap: _onItemTapped,
            //       showSelectedLabels: true,
            //       selectedFontSize: screenHeight * 0.014,
            //       iconSize: screenHeight * 0.05,
            //       selectedItemColor: Color(0XFF0A2E52),
            //       unselectedItemColor: Color(0XFF4A8CCF),
            //       items: [
            //         BottomNavigationBarItem(
            //           icon: Image.asset(
            //             "assets/icons/home.png",
            //             height: screenHeight * 0.025,
            //             color: Color(0XFF0A2E52),
            //           ),
            //           label: "Home",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Image.asset(
            //             "assets/icons/categories.png",
            //             height: screenHeight * 0.025,
            //             color: Color(0XFF0A2E52),
            //           ),
            //           label: "Categories",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Image.asset(
            //             "assets/icons/new.png",
            //             height: screenHeight * 0.025,
            //             color: Color(0XFF0A2E52),
            //           ),
            //           label: "New",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Image.asset(
            //             "assets/icons/cart.png",
            //             height: screenHeight * 0.025,
            //             color: Color(0XFF0A2E52),
            //           ),
            //           label: "Cart",
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            //FLOATING BOTTOM NAV BAR
          ],
        ),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            backgroundColor:Colors.white,
            elevation: 9,
            type: BottomNavigationBarType.fixed,
            iconSize:screenHeight*0.8,
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
        height:screenHeight*0.035,
        width:screenWidth*0.08,
        color: isActive ? Color(0XFFd93932) : Color(0XFF124d86),
      ),
    );
  }
}
