import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import '../../View Models/CartListViewModel/CartListVM.dart';

class Cartitems extends StatefulWidget {
  final String img;
  final String name;
  final String price;
  final VoidCallback onDelete;
  // ADD THESE:
  final Function(String size, int qty) onUpdate;
  final String size;
  final int qty;

  const Cartitems({
    required this.img,
    required this.name,
    required this.price,
    required this.onDelete,
    required this.onUpdate,
    required this.size,
    required this.qty,
  });

  @override
  State<Cartitems> createState() => _CartitemsState();
}

class _CartitemsState extends State<Cartitems> {
  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  bool isWishlisted = false;

  late int quantity;
  late String selectedSize;

  @override
  void initState() {
    super.initState();
    quantity = widget.qty;
    selectedSize = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    int unitPrice = int.parse(
      widget.price.replaceAll("₹", "").replaceAll(",", "").trim(),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PRODUCT IMAGE
          Container(
            height: screenHeight * 0.2,
            width: screenWidth * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  widget.img.isNotEmpty
                      ? widget.img
                      : 'assets/PlaceHolder/Product_placeholder.avif',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
          // PRODUCT DETAILS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: GoogleFonts.gfsDidot(
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.w700,
                  color:Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),

              Text(
                'Price: ₹${unitPrice * quantity}',
                style: GoogleFonts.getFont(
                  AppFonts.appbar,
                  fontSize: screenHeight * 0.014,
                  fontWeight: FontWeight.w500,
                  color:Colors.grey.shade700,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
              // SIZE DROPDOWN
              Container(
                height: screenHeight * 0.035,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.lightBlueAccent, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedSize,
                    dropdownColor:Colors.white,
                    items: sizes.map((s) {
                      return DropdownMenuItem(value: s, child: Text("Size $s",
                        style: GoogleFonts.getFont(
                          AppFonts.title,
                          fontSize: screenHeight * 0.014,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pagehead,
                        ),));
                    }).toList(),
                    onChanged: (v) {
                      setState(() => selectedSize = v!);
                      widget.onUpdate(selectedSize, quantity);
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // QUANTITY BUTTONS
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() => quantity--);
                        widget.onUpdate(selectedSize, quantity);
                      }
                    },
                    child: Icon(Icons.remove, color:AppColors.textFieldHint),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "$quantity",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize:screenHeight*0.018),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() => quantity++);
                      widget.onUpdate(selectedSize, quantity);
                    },
                    child: Icon(Icons.add, color:AppColors.textFieldHint),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // DELETE + WISHLIST
          Column(
            children: [
              // DELETE PRODUCT
              GestureDetector(
                onTap: () {
                  final cartVM = Provider.of<Cartlistviewmodel>(
                    context,
                    listen: false,
                  );

                  // Remove item from cart
                  cartVM.removeItemByName(widget.name);

                  // Call the original delete callback
                  widget.onDelete();
                },
                child: Image.asset(
                  "assets/icons/bin.png",
                  height: screenHeight * 0.03,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
