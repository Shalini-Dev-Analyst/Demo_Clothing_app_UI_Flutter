import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/View/Category%20Screen/ProductScreen/ProductScreen.dart';
import 'package:s_apparels_clothes/Widgets/CategoryScreen/ProductScreen/ProductDetailCard.dart';

import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_fonts.dart';
import '../../../View Models/AccountScreen/WishlistVM.dart';
import '../../../View Models/CartListViewModel/CartListVM.dart';
import '../../../View Models/CategoryScreen/Product/Product_View_Model.dart';
import '../../../Widgets/CategoryScreen/ProductScreen/ProductCards.dart';
import '../../Account Screen/Wish List Screen/wishList.dart';
import '../../CartScreen/CartScreen.dart';
import '../../Home Screen/homescreen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String price;
  const ProductDetailScreen({super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.price,});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ScrollController _scrollController;
  bool showBottomNav = false;
  String locationFull = 'Fetching...';
  bool locationFetched = false;
  bool isWishlisted = false;
  bool isAddedToCart = false;
  int quantity = 1;
  String selectedSize = "M";
  bool isAddedToBag = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cartVM = Provider.of<Cartlistviewmodel>(context);

    isAddedToBag = cartVM.cart.any((item) => item["name"] == widget.title);
  }


  @override
  void initState() {
    super.initState();
    _fetchLocation();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 450) {
        if (showBottomNav) {
          setState(() => showBottomNav = false);
        }
      } else {
        if (!showBottomNav) {
          setState(() => showBottomNav = true);
        }
      }
    });
  }


  ///FUNCTIONS USED
  //FETCHING LOCATION
  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => locationFull = "Turn ON Location");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => locationFull = "Permission denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => locationFull = "Permission denied (Forever)");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark p = placemarks.first;
        setState(() {
          locationFull =
          "${p.name ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.postalCode ?? ''}";
        });
      }
    } catch (e) {
      setState(() => locationFull = "Error fetching location");
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
        return "${placemark.subLocality ?? ''}, ${placemark.locality ?? ''}";
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
        return "${p.name ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.postalCode ?? ''}";
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
        bottomNavigationBar: Visibility(
        visible: showBottomNav,
        child: Container(
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
                "MRP: ₹${(double.parse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) * quantity).toStringAsFixed(2)}\n(Incl. All Taxes)",
                style: GoogleFonts.getFont(
                  AppFonts.body,
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.w500,
                  color:Colors.grey.shade700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final cartVM = Provider.of<Cartlistviewmodel>(context, listen: false);
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>Cartscreen()));
                  cartVM.addToCart({
                    "img": widget.image,
                    "name": widget.title,
                    "price": widget.price,
                    "size": selectedSize,
                    "qty": quantity,
                  });


                  setState(() => isAddedToBag = true);
                },
                child: Container(
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.35,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.9),
                        Color(0XFFd93932).withOpacity(0.9)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Check Out",
                    style: GoogleFonts.getFont(
                      AppFonts.title,
                      fontSize: screenHeight * 0.015,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFFE9F3FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          MaterialPageRoute(builder: (_) => Productscreen()),
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
              // SizedBox(height: screenHeight * 0.025),
              // StaggeredSlideIn(
              //   beginOffset: Offset(-0.6, 0),
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: screenWidth * 0.01,
              //       ),
              //       child: Container(
              //         height: screenHeight * 0.17,
              //         width: screenWidth * 1,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           image: DecorationImage(
              //             image: AssetImage(
              //               "assets/banners/banner/banner2 (1).jpg",
              //             ),
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              //GRID
              SizedBox(height:screenHeight*0.02,),
              ProductDetailScreenCard(
                title: widget.title,
                description: widget.description,
                image: widget.image,
                price: widget.price,

                onSizeChanged: (value) {
                  setState(() => selectedSize = value);
                },

                onQuantityChanged: (value) {
                  setState(() => quantity = value);
                },
              ),
              //DELIVERY ESTIMATION
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Details",
                        style:GoogleFonts.gfsDidot(
                          fontSize: screenHeight*0.022,
                          color: AppColors.pagehead,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(height:screenHeight*0.02),
                    Container(
                      height:screenHeight*0.04,
                      width:screenWidth*1,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Colors.lightBlueAccent.withOpacity(0.1),
                      ),
                      child:Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: screenHeight * 0.025,
                            color: AppColors.pagehead,
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          Text("Delivery Address",
                              style:GoogleFonts.getFont(
                                AppFonts.body,
                                fontSize: screenHeight*0.014,
                                color:Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),),
                          SizedBox(width: screenWidth * 0.02),
                          Flexible(
                            child: Text(
                              locationFull,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                                style:GoogleFonts.gfsDidot(
                                  fontSize: screenHeight*0.014,
                                  color:Colors.blue,
                                  fontWeight: FontWeight.w700,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:screenHeight*0.01),
                    Container(
                      height:screenHeight*0.04,
                      width:screenWidth*1,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Colors.lightBlueAccent.withOpacity(0.1),
                      ),
                      child:Row(
                        mainAxisAlignment: .start,
                        children: [
                          Image.asset("assets/icons/delivery.png",color:AppColors.pagehead,height:screenHeight*0.03,),
                          SizedBox(width: screenWidth*0.05,),
                          Text("Deliver on within 3-4 days Of Order",
                              style:GoogleFonts.getFont(
                                AppFonts.body,
                                fontSize: screenHeight*0.014,
                                color:Colors.black87,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height:screenHeight*0.01),
                    Container(
                      height:screenHeight*0.04,
                      width:screenWidth*1,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Colors.lightBlueAccent.withOpacity(0.1),
                      ),
                      child:Row(
                        mainAxisAlignment: .start,
                        children: [
                          Image.asset("assets/icons/delivery.png",color:AppColors.pagehead,height:screenHeight*0.03,),
                          SizedBox(width: screenWidth*0.05,),
                          Text("Fast Delivery On Time",
                              style:GoogleFonts.getFont(
                                AppFonts.body,
                                fontSize: screenHeight*0.014,
                                color:Colors.black87,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //SIMILAR PRODUCTS GRID
              SizedBox(height:screenHeight*0.03),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                ),
                child: Text("Similar Products",
                    style:GoogleFonts.gfsDidot(
                      fontSize: screenHeight*0.022,
                      color: AppColors.pagehead,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                ),
                child: GridView.builder(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
