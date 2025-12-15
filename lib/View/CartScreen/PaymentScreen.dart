import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/app_colors.dart';
import '../../Utils/Constants/app_fonts.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';
import '../../Widgets/CartScreen/CheckOutStepper.dart';
import '../../Widgets/CartScreen/order_details_bottom_sheet.dart';
import '../../Widgets/CategoryScreen/StaggeredSlideIn.dart';
import 'AddressScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "";
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
                      Provider.of<Cartlistviewmodel>(context, listen: false)
                          .setPaymentMethod(selectedMethod);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => OrderDetailsBottomSheet(),
                      );

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
                      "Check Out",
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
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressScreen()));
                      },
                      child: Icon(Icons.arrow_back_ios,color:AppColors.pagehead,size:screenHeight*0.025)),
                  Text("Payment",
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
            CheckoutStepper(currentStep: 2),
            //APPLY COUPONS
            SizedBox(height: screenHeight * 0.04),
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
            //PAYMENTS
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding:EdgeInsets.only(left:screenWidth*0.04,right:screenWidth*0.04,top: screenHeight*0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TOPIC
                  Text("Choose Payment Method",
                    style: GoogleFonts.gfsDidot(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w700,
                      color:AppColors.pagehead,
                    ),),
                  SizedBox(height: screenHeight * 0.03),
                  //UPI PAYMENTS
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMethod =
                        (selectedMethod == "UPI") ? "" : "UPI";
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/logo/upi-removebg-preview.png",  height: screenHeight * 0.03),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "UPI Payments",
                          style: GoogleFonts.getFont(
                            AppFonts.body,
                            fontSize: screenHeight * 0.016,
                            fontWeight: FontWeight.w500,
                            color:AppColors.pagesubtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // SHOW UPI ROW ONLY IF SELECTED
                  if (selectedMethod == "UPI")
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/logo/gpay-removebg-preview.png",
                              height: screenHeight * 0.05),
                          Image.asset("assets/logo/paytm-removebg-preview.png",
                              height: screenHeight * 0.05),
                          Image.asset("assets/logo/phonepe-removebg-preview.png",
                              height: screenHeight * 0.05),
                          Image.asset(
                              "assets/logo/paypal-removebg-preview.png",
                              height: screenHeight * 0.04),
                        ],
                      ),
                    ),
                  Divider(),
                  SizedBox(height: screenHeight * 0.01),
                  //CARDS
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMethod =
                        (selectedMethod == "Cards") ? "" : "Cards"; // toggle logic
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/logo/card-removebg-preview.png",  height: screenHeight * 0.03),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Cards",
                          style: GoogleFonts.getFont(
                            AppFonts.body,
                            fontSize: screenHeight * 0.016,
                            fontWeight: FontWeight.w500,
                            color:AppColors.pagesubtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // SHOW CARD ROW ONLY IF SELECTED
                  if (selectedMethod == "Cards")
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/logo/cards-removebg-preview.png",
                              height: screenHeight * 0.09),
                        ],
                      ),
                    ),
                  Divider(),
                  SizedBox(height: screenHeight * 0.01),
                  //COD
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMethod =
                        (selectedMethod == "COD") ? "" : "COD";
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/logo/cod-removebg-preview.png",  height: screenHeight * 0.03),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Cash On Delivery",
                          style: GoogleFonts.getFont(
                            AppFonts.body,
                            fontSize: screenHeight * 0.016,
                            fontWeight: FontWeight.w500,
                            color:AppColors.pagesubtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
