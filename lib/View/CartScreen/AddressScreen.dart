import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../Widgets/CartScreen/CheckOutStepper.dart';
import '../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import '../Account Screen/Address Screen/savedAddress.dart';
import 'CartScreen.dart';
import 'PaymentScreen.dart';


class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String locationFull = 'Fetching...';
  bool locationFetched = false;

  @override
  void initState() {
    super.initState();
    //LOCATION FETCH
    _fetchLocation();

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
          "${p.name ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.postalCode ?? ''}";
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
    return Scaffold(
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
                Image.asset("assets/logo/Logo-02.png",height:screenHeight*0.05,),
                GestureDetector(
                  onTap: cartVM.cart.isEmpty
                      ? null
                      : () {
                    String fullAddress = locationFull;

                    Provider.of<Cartlistviewmodel>(context, listen: false)
                        .setAddress(fullAddress);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PaymentScreen()),
                    );                  },
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
                      "Continue",
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
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>Cartscreen()));
                      },
                      child: Icon(Icons.arrow_back_ios,color:AppColors.pagehead,size:screenHeight*0.025)),
                  Text("Confirm Address",
                      style:GoogleFonts.getFont(
                          AppFonts.title,
                          fontWeight:FontWeight.w500,
                          fontSize: screenHeight*0.025,
                          color:AppColors.pagehead
                      )),
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
            SizedBox(height: screenHeight * 0.02),
            CheckoutStepper(currentStep: 1),
            //LOCATION BAR
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.04),
              child: FutureBuilder<String>(
                future: Future.value(locationFull),
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              size: screenHeight * 0.025,
                              color: AppColors.pagehead,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              "Delivery:",
                              style: GoogleFonts.gfsDidot(
                                fontWeight: FontWeight.w700,
                                fontSize: screenHeight * 0.018,
                                color: Color(0xFF002B5B),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Center(
                          child: Text(
                            locationFull,
                            style: GoogleFonts.getFont(
                              AppFonts.body,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.016,
                              color:Colors.black87,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            //CHANGE BUTTON
            SizedBox(height: screenHeight * 0.025),
            Align(
              alignment: Alignment.center,
                child:GestureDetector(
                  onTap:(){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>SavedAddressScreen()));
                  },
                  child:Container(
                    height:screenHeight*0.05,
                    width:screenWidth*0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.red.shade700
                    ),
                    alignment: Alignment.center,
                    child:Text("Change Address",
                      textAlign: TextAlign.center,
                      style:GoogleFonts.getFont(
                          AppFonts.body,
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight * 0.018,
                          color: AppColors.containerOverlay
                      ),),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
