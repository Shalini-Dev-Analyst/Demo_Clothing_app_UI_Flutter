import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Constants/app_fonts.dart';
import '../Initial Screen/initialscreen.dart';
import '../OTP Screen/otpscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}


Future<void> saveUserData(String name, String phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userPhone', phone);
  await prefs.setBool('loggedIn', true);
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Initialscreen()));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.4,
                width: screenWidth * 1,
                decoration: BoxDecoration(
                  color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: .center,
                      children: [
                        Image.asset(
                          "assets/logo/Logo-02.png",
                          fit: BoxFit.contain,
                          height: screenHeight * 0.13,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Text(
                          "Welcome Back to Stylish Living — Discover, Select & Shine",
                          style: GoogleFonts.getFont(
                            AppFonts.appbar,
                            fontWeight: FontWeight.w500,
                            fontSize: screenHeight * 0.014,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Stay Trendy. Shop Smart",
                          style: GoogleFonts.getFont(
                            AppFonts.appbar,
                            fontWeight: FontWeight.w500,
                            fontSize: screenHeight * 0.014,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height:screenHeight*0.65,
                width: screenWidth*1,
                decoration:BoxDecoration(
                  color:Color(0XFF1B3C73),
                  border: Border.all(color:Color(0XFF1B3C73)),
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))
                ),
                child:Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical:screenHeight*0.04),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Log In",
                          style: GoogleFonts.gfsDidot(
                            fontWeight: FontWeight.w700,
                            fontSize: screenHeight * 0.026,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Your Number",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w500,
                                fontSize: screenHeight * 0.018,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.getFont(
                                AppFonts.body,
                                fontWeight: FontWeight.w500,
                                fontSize: screenHeight * 0.016,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter Your 10-Digit Mobile Number",
                                hintStyle: GoogleFonts.playfairDisplay(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenHeight * 0.014,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),

                                //Only show cancel icon when text is entered
                                suffixIcon: _phoneController.text.isNotEmpty
                                    ? IconButton(
                                  onPressed: () {
                                    _phoneController.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                      color: Colors.white,
                                  ),
                                )
                                    : null,
                              ),
                              inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your mobile number";
                                }

                                //10-DIGITS ONLY
                                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                  return "Enter a valid 10-digit mobile number";
                                }

                                return null;
                              },
                            ),
                            SizedBox(height:screenHeight*0.05,),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber: '+91${_phoneController.text}',
                                      verificationCompleted: (PhoneAuthCredential credential) async {},
                                      verificationFailed: (FirebaseAuthException e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(e.message ?? "Error")),
                                        );
                                      },
                                      codeSent: (String verificationId, int? resendToken) {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: const Duration(milliseconds: 700),
                                            reverseTransitionDuration: const Duration(milliseconds: 500),
                                            pageBuilder: (context, animation, secondaryAnimation) =>
                                                Otpscreen(verificationId: verificationId),
                                            transitionsBuilder:
                                                (context, animation, secondaryAnimation, child) {
                                              // Slide from right
                                              final slideAnimation = Tween<Offset>(
                                                begin: const Offset(0, 0),
                                                end: Offset.zero,
                                              ).animate(
                                                  CurvedAnimation(parent: animation, curve: Curves.easeOut));

                                              // Fade in
                                              final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
                                                  CurvedAnimation(parent: animation, curve: Curves.easeOut));

                                              // Scale up
                                              final scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
                                                  CurvedAnimation(parent: animation, curve: Curves.easeOut));

                                              return SlideTransition(
                                                position: slideAnimation,
                                                child: FadeTransition(
                                                  opacity: fadeAnimation,
                                                  child: ScaleTransition(
                                                    scale: scaleAnimation,
                                                    child: child,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      codeAutoRetrievalTimeout: (String verificationId) {},
                                    );
                                  }
                                },
                                child: Container(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFd93932),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.getFont(
                                        AppFonts.body,
                                        fontSize: screenHeight * 0.018,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

