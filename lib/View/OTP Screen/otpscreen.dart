import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Constants/app_fonts.dart';
import '../Home Screen/homescreen.dart';
import '../Login Screen /loginscreen.dart';

class Otpscreen extends StatefulWidget {
  final String verificationId;
  const Otpscreen({super.key,required this.verificationId});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
        (_) => TextEditingController(),
  );
  bool loading = false;


  Future<void> saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", true);
  }

  //DIALOG MESSAGE
  void showMessageDialog(String message) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(horizontal:screenWidth*0.05,vertical: screenHeight*0.01),
        margin: EdgeInsets.only(bottom:screenHeight*0.05, left:screenWidth*0.2, right:screenWidth*0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor:Color(0XFF0D4ABC),
        elevation: 5,
        duration: Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            AppFonts.appbar,
            fontSize:screenHeight*0.012,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  //VERIFICATION FUNCTION
  Future<void> verifyOtp() async {
    String otp = _controllers.map((c) => c.text).join();

    if (otp.length != 6) {
      showMessageDialog("Enter Valid 6-Digit OTP");
      return;
    }
    try {
      setState(() => loading = true);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() => loading = false);
      showMessageDialog("OTP Verified Successfully!");
      await FirebaseAuth.instance.signInWithCredential(credential);
      await saveLogin();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, animation, __) {
            return FadeTransition(
              opacity: animation,
              child: Homescreen(),
            );
          },
        ),
      );
      } catch (e) {
      setState(() => loading = false);
      showMessageDialog("Incorrect OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Loginscreen()));
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
            body:Column(
              children: [
                Container(
                  height: screenHeight * 0.4,
                  width: screenWidth * 1,
                  decoration: BoxDecoration(color: Colors.white),
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
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Your Style Starts Here",
                            style: GoogleFonts.getFont(
                              AppFonts.appbar,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.016,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height:screenHeight*0.6,
                  width: screenWidth*1,
                  decoration:BoxDecoration(
                      color: Color(0XFFb42220).withOpacity(1),
                      border: Border.all(color:Color(0XFFb42220)),
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.05,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TITLE FIELD
                            Text(
                              "Enter Your 6 Digit OTP",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w500,
                                fontSize: screenHeight * 0.018,
                                color:Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            //OTP INPUT BOXES
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(6, (index) {
                                return SizedBox(
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.12,
                                  child: TextField(
                                    style: GoogleFonts.merriweather(
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenHeight * 0.02,
                                        color:Colors.white,
                                    ),
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),

                                    onChanged: (value) {
                                      if (value.isNotEmpty && index < 5) {
                                        _focusNodes[index + 1].requestFocus();
                                      } else if (value.isEmpty && index > 0) {
                                        _focusNodes[index - 1].requestFocus();
                                      }
                                    },
                                  ),
                                );
                              }),
                            ),
                            //VERIFY BUTTON
                            SizedBox(height: screenHeight * 0.05),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: screenWidth * 0.4,
                                child: ElevatedButton(
                                  onPressed: loading ? null : verifyOtp,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04,
                                      vertical: screenHeight * 0.012,
                                    ),
                                    backgroundColor:Color(0XFF093383),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: loading
                                      ? CircularProgressIndicator(color: Colors.white)
                                      : Text(
                                        "Verify OTP",
                                        style:GoogleFonts.getFont(
                                          AppFonts.body,
                                          fontSize:screenHeight*0.018,
                                          fontWeight: FontWeight.w500,
                                          color:Colors.white,
                                        ),)
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ),
              ],
            )
      ),
    );
  }
}
