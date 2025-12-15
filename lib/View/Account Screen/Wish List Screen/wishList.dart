// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../../../Utils/Constants/app_fonts.dart';
import '../../../View Models/AccountScreen/WishlistVM.dart';
import '../../../Widgets/AccountScreen/WishList.dart';
import '../../Home Screen/homescreen.dart';


class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    final wishlistVM = Provider.of<WishlistVM>(context);
    return Scaffold(
      backgroundColor:Colors.white,
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: EdgeInsets.only(
                left: screenwidth * 0.04,
                right: screenwidth * 0.04,
                top: screenheight * 0.05,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Homescreen()),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.pagehead,
                      size: screenheight * 0.025,
                    ),
                  ),
                  Text(
                    "WishList",
                    style: GoogleFonts.getFont(
                      AppFonts.appbar,
                      fontWeight: FontWeight.w500,
                      fontSize: screenheight * 0.022,
                      color: AppColors.pagehead,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/logo/Logo-02.png",
                    height: screenheight * 0.035,
                  ),
                ],
              ),
            ),
            //TOPIC
            SizedBox(height:screenheight*0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:screenwidth*0.04),
              child: Column(
                children: [
                  Align(
                    alignment:Alignment.center,
                    child: Text("Added WishListed Items",
                      style: GoogleFonts.gfsDidot(
                        fontSize: screenheight * 0.02,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF0A2E52),
                      ),),
                  ),
                ],
              ),
            ),
            //WISH LIST ITEMS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.039),
              child: SizedBox(
                height: screenheight * 0.7,
                child: wishlistVM.wishlist.isEmpty
                    ? Center(
                  child: Text(
                    "No products added 😢\nPlease Revisit and Wishlist Some\nProduct You May Like😍",
                    style: GoogleFonts.getFont(
                      AppFonts.contents,
                      fontSize: screenheight * 0.015,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                    : ListView.separated(
                  itemCount: wishlistVM.wishlist.length,
                  itemBuilder: (context, index) {
                    final p = wishlistVM.wishlist[index];

                    return Wishlistlayout(
                      image: p["img"],
                      title: p["name"],
                      price: p["price"],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenheight * 0.005,
                      ),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
