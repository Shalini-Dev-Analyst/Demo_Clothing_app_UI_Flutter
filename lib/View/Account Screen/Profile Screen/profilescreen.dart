// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Widgets/AccountScreen/ProfileScreenFields.dart';
import '../../../Models/Profile/Profile_data.dart';
import '../../../Utils/Constants/app_colors.dart';
import '../AccountScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If editing existing profile, set initial values here
    nameController.text = "";
    mobileController.text = "";
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
    // Load saved profile data
    ProfileData.loadUserData().then((_) {
      nameController.text = ProfileData.userName.value;
      mobileController.text = ProfileData.mobileNumber.value;
      setState(() {});
    });


    nameController.addListener(() => setState(() {}));
    mobileController.addListener(() => setState(() {}));
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
            // HEADER
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.05),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Accountscreen()));
                      },
                      child: Icon(Icons.arrow_back_ios,
                          color: AppColors.pagehead,
                          size: screenHeight * 0.025)),
                  SizedBox(width:screenWidth*0.05),
                  Text("My Profile",
                      style: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight * 0.025,
                          color: AppColors.pagehead)),
                  Spacer(),
                  Image.asset("assets/logo/Logo-02.png",height:screenHeight*0.05,),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            // FORM
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ProfileFields(
                      label: "Full Name",
                      controller: nameController,
                      initialValue: "",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30)
                      ],
                      validator: (v) =>
                      v == null || v.isEmpty ? "Enter your name" : null,
                    ),

                    ProfileFields(
                      label: "Mobile Number",
                      controller: mobileController,
                      initialValue: "",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (v) =>
                      v == null || v.isEmpty ? "Enter mobile number" : null,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            // SAVE BUTTON
            Container(
              alignment: Alignment.center,
              height: screenHeight * 0.06,
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (nameController.text.isNotEmpty && mobileController.text.isNotEmpty)
                    ? Color(0XFFFF0000)
                    : Colors.grey.withOpacity(0.5),
              ),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    // Save profile data persistently
                    await ProfileData.saveUserData(
                      nameController.text.trim(),
                      mobileController.text.trim(),
                    );

                    // Show auto-dismiss popup
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 1), () {
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        });
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: const Text(
                            "Success",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text("Profile updated successfully!"),
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Save Changes",
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
    );
  }
}
