// ignore_for_file: unused_import, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import 'package:s_apparels_clothes/View/Account%20Screen/AccountScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Widgets/AccountScreen/AddressScreen/AddAddressFields.dart';
import '../../CartScreen/AddressScreen.dart';
import '../../Home Screen/homescreen.dart';


class AddAddressScreen extends StatefulWidget {
  final String? type;
  final IconData? icon;
  final String? apartment;
  final String? flat;
  final String? landmark;
  final String? city;
  final String? mobile;
  final String? addressId;
  final String? customerAccessToken;

  const AddAddressScreen({
    super.key,
    this.type,
    this.icon,
    this.apartment,
    this.flat,
    this.landmark,
    this.city,
    this.mobile,
    this.addressId,
    this.customerAccessToken,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}


class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  String selectedOption = "";
  IconData? selectedIcon;

  bool get allFieldsValid =>
      _formKey.currentState?.validate() == true && selectedOption.isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (widget.apartment != null) apartmentController.text = widget.apartment!;
    if (widget.flat != null) flatController.text = widget.flat!;
    if (widget.landmark != null) landmarkController.text = widget.landmark!;
    if (widget.city != null) cityController.text = widget.city!;
    if (widget.mobile != null) mobileController.text = widget.mobile!;
    if (widget.type != null) {
      selectedOption = widget.type!;
      selectedIcon = widget.icon ?? Icons.home;
    }
  }

  void dispose() {
    apartmentController.dispose();
    flatController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //HEADER
            Padding(
              padding:EdgeInsets.only(left:screenWidth*0.04,right:screenWidth*0.04,top: screenHeight*0.05),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>Accountscreen()));
                      },
                      child: Icon(Icons.arrow_back_ios,color:AppColors.pagehead,size:screenHeight*0.025)),
                  Text("Add New Address",
                      style:GoogleFonts.getFont(
                        AppFonts.appbar,
                          fontWeight:FontWeight.w500,
                          fontSize: screenHeight*0.024,
                          color:AppColors.pagehead
                      )),
                  Spacer(),
                  Image.asset("assets/logo/Logo-02.png",height:screenHeight*0.035,),
                ],
              ),
            ),
            SizedBox(height:screenHeight*0.04),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:screenWidth*0.06),
              child: Form(
                key: _formKey,
                onChanged: () => setState(() {}),
                child: Column(
                  children: [
                    AddressEdits(
                      label: 'Enter your apartment / building / area',
                      controller: apartmentController,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      validator: (v) =>
                      v == null || v.isEmpty ? "Enter apartment/area" : null, initialValue: '',
                    ),
                    AddressEdits(
                      label: 'Flat no. / House no. / Floor / Block',
                      controller: flatController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      validator: (v) =>
                      v == null || v.isEmpty ? "Enter flat/house no." : null, initialValue: '',
                    ),
                    AddressEdits(
                      label: 'Landmark (Optional)',
                      controller: landmarkController,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)], initialValue: '',
                    ),
                    AddressEdits(
                      label: 'City',
                      controller: cityController,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      validator: (v) => v == null || v.isEmpty ? "Enter city" : null, initialValue: '',
                    ),
                    AddressEdits(
                      label: 'Mobile number',
                      controller: mobileController,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Enter mobile number";
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                          return "Enter valid 10-digit number";
                        }
                        return null;
                      }, initialValue: '',
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Save as",
                          style: GoogleFonts.jost(
                            fontWeight: FontWeight.w400,
                            fontSize: screenHeight * 0.018,
                            color: const Color(0XFF080808),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _options(Icons.home, "Home", screenHeight, screenWidth),
                            _options(Icons.work, "Work", screenHeight, screenWidth),
                            _options(
                                Icons.location_on, "Others", screenHeight, screenWidth),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    GestureDetector(
                      onTap: () {
                        if (!_formKey.currentState!.validate() || selectedOption.isEmpty) {
                          return;
                        }

                        final newAddress = {
                          "type": selectedOption,
                          "icon": selectedIcon,
                          "apartment": apartmentController.text,
                          "flat": flatController.text,
                          "landmark": landmarkController.text,
                          "city": cityController.text,
                          "mobile": mobileController.text,
                          "addressId": DateTime.now().millisecondsSinceEpoch.toString(),
                          "customerAccessToken": "123456",
                        };

                        Navigator.pop(context, newAddress);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: allFieldsValid
                              ? AppColors.textFieldHint
                              : const Color(0XFFCBCBCB),
                        ),
                        child: Text(
                          "Save Address",
                          style: GoogleFonts.gfsDidot(
                            fontWeight: FontWeight.w900,
                            fontSize: screenHeight * 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _options(
      IconData icn, String text, double screenHeight, double screenWidth) {
    final isSelected = selectedOption == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = text;
          selectedIcon = icn;
        });
      },
      child: Container(
        height: screenHeight * 0.045,
        width: screenWidth * 0.267,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? Colors.pink.shade300 : Colors.lightBlueAccent.shade200,
            width: 1,
          ),
          color: isSelected ? Colors.pink.shade300  : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icn,
                size: screenHeight * 0.02,
                color: isSelected ? Colors.white : Colors.lightBlueAccent.shade200),
            SizedBox(width:screenWidth*0.02),
            Text(
              text,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w500,
                fontSize: screenHeight * 0.014,
                color: isSelected ? Colors.white :Colors.lightBlueAccent.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



