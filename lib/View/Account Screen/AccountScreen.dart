// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';

import '../../Models/Profile/Profile_data.dart';
import '../../Utils/Constants/app_colors.dart';
import '../../View Models/AccountScreen/WishlistVM.dart';
import '../CartScreen/PaymentScreen.dart';
import '../Home Screen/homescreen.dart';
import '../Initial Screen/initialscreen.dart';
import 'Address Screen/savedAddress.dart';
import 'Profile Screen/profilescreen.dart';
import 'Wish List Screen/wishList.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
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
                    Text("User Account",
                        style:GoogleFonts.getFont(
                            AppFonts.appbar,
                            fontWeight:FontWeight.w500,
                            fontSize: screenHeight*0.024,
                            color:AppColors.pagehead
                        )),
                    Spacer(),
                    Image.asset(
                      "assets/logo/Logo-02.png",
                      height: screenHeight * 0.035,
                    ),
                  ],
                ),
              ),
              //PROFILE
              Container(
                padding: EdgeInsets.only(left:screenWidth*0.09,right:screenWidth*0.09,top:screenHeight*0.07,bottom:screenHeight*0.05),
                color: Color(0XFFFFFCFB),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.005),
                        ValueListenableBuilder(
                          valueListenable: ProfileData.userName,
                          builder: (context, String value, _) {
                            return SizedBox(
                              width: screenWidth * 0.5,
                              child: Text(
                                value,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.getFont(
                                  AppFonts.contents,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenHeight * 0.024,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height:screenHeight*0.01),
                        ValueListenableBuilder(
                          valueListenable: ProfileData.mobileNumber,
                          builder: (context, String value, _) {
                            return Text(
                              value,
                              style: GoogleFonts.getFont(
                                AppFonts.contents,
                                color:Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize:screenHeight*0.018,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap:(){
                          Navigator.push(context,MaterialPageRoute(builder: (_)=>ProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius:50,
                          backgroundColor: Colors.pink.shade50,
                            child: Center(child: Image.asset( "assets/icons/profile.png", height: screenHeight * 0.07, color:Colors.pink.shade100, )))),
                  ],
                ),
              ),
              //SECTIONS
              Padding(
                padding:EdgeInsets.symmetric(horizontal:screenWidth*0.07,vertical:screenHeight*0.01),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/orders.png",
                        height: screenHeight * 0.035,
                        color:Colors.grey.shade400
                      ),
                      title: Text(
                        "My Orders",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (_) => Orderslist()),
                        // );
                      },
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/profile.png",
                        height: screenHeight * 0.035,
                          color:Colors.grey.shade400
                      ),
                      title: Text(
                        "My Profile",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProfileScreen()),
                        );
                      },
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/loaction.png",
                        height: screenHeight * 0.035,
                          color:Colors.grey.shade400
                      ),
                      title: Text(
                        "Delivery Address",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SavedAddressScreen()),
                        );
                      },
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Consumer<WishlistVM>(
                      builder: (context, wishlistVM, child) {
                        return ListTile(
                          leading: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                "assets/icons/wishlist.png",
                                height: screenHeight * 0.036,
                                  color:Colors.grey.shade400
                              ),
                              //Dynamic Badge Counter
                              if (wishlistVM.count > 0)
                                Positioned(
                                  right: -6,
                                  top: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      wishlistVM.count.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(
                            "My Wishlist",
                            style: GoogleFonts.getFont(
                              AppFonts.body,
                              color: Colors.black87,
                              fontSize: screenHeight * 0.020,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => WishlistScreen()),
                            );
                          },
                        );
                      },
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/payment method.png",
                        height: screenHeight * 0.035,
                          color:Colors.grey.shade400
                      ),
                      title: Text(
                        "Payment Methods",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>PaymentScreen()));
                      },
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/help.png",
                        height: screenHeight * 0.035,
                          color:Colors.grey.shade400
                      ),
                      title: Text(
                        "Contact Us",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/setting.png",
                        height: screenHeight * 0.035,
                          color:Colors.grey.shade400
                      ),
                      title: Text(
                        "Settings",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/q&a.png",
                        height: screenHeight * 0.035,
                          color:Colors.grey.shade400
                      ),
                      title: Text(
                        "FAQ's",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      indent: screenHeight * 0.02,
                      endIndent: screenWidth * 0.06,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ListTile(
                      leading: Image.asset(
                        "assets/icons/log out.png",
                        height: screenHeight * 0.035,
                        color:Colors.grey.shade400
                      ),
                      title: Text(
                        "Log Out",
                        style: GoogleFonts.getFont(
                          AppFonts.body,
                          color: Colors.black87,
                          fontSize: screenHeight * 0.020,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
