import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/View/CartScreen/CheckoutScreen.dart';

import '../../View Models/CartListViewModel/CartListVM.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  const OrderDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cartVM = Provider.of<Cartlistviewmodel>(context);

    double subtotal = cartVM.getTotalPrice();
    double delivery = 50;
    double gst = subtotal * 0.05;
    double total = subtotal + delivery + gst;

    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Container(
              height: 4, width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          SizedBox(height: 20),

          Text("Order Details",
            style: GoogleFonts.gfsDidot(
              fontSize: 22, fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 15),

          // -----------------------
          // DELIVERY ADDRESS
          // -----------------------
          Text("Delivery Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(cartVM.selectedAddress),

          SizedBox(height: 20),

          // -----------------------
          // PAYMENT METHOD
          // -----------------------
          Text("Payment Method",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(cartVM.selectedPaymentMethod),

          SizedBox(height: 20),

          // -----------------------
          // BILL DETAILS
          // -----------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal:"),
              Text("₹${subtotal.toStringAsFixed(2)}"),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delivery Charges:"),
              Text("₹${delivery.toStringAsFixed(2)}"),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("GST (5%):"),
              Text("₹${gst.toStringAsFixed(2)}"),
            ],
          ),

          Divider(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:",
                style: GoogleFonts.gfsDidot(
                  fontSize: 20, fontWeight: FontWeight.bold,
                ),
              ),
              Text("₹${total.toStringAsFixed(2)}",
                style: GoogleFonts.gfsDidot(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CheckoutScreen()),
              );
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Confirm Corder",
                style: GoogleFonts.getFont(
                  AppFonts.title,
                  color: Colors.white,
                  fontSize: 18, fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

