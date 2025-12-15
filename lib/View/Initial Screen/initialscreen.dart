import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/Constants/app_fonts.dart';
import '../Login Screen /loginscreen.dart';
import '../Register Screen/registerscreen.dart';

class Initialscreen extends StatelessWidget {
  const Initialscreen({super.key});

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
        backgroundColor: Color(0XFFFFFFFF),
        body: Column(
          children: [
            Container(
              height: screenHeight * 1,
              width: screenWidth,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/bgs/init7.png",
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight * 0.6,
                    color:Color(0XFFFF0000),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: screenHeight * 0.45,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Color(0XFFF0F0F0),
                        border: Border.all(color: Color(0XFFF0F0F0)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top:screenHeight*0.02,left:screenWidth*0.02,right:screenWidth*0.02,bottom:screenHeight*0.05),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: .spaceAround,
                          children: [
                            Text("Uncover Your\nTrue Fashion\nSense",
                            textAlign: TextAlign.center,
                            style:GoogleFonts.getFont(
                              AppFonts.contents,
                              color:Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight*0.05
                            ),),
                            Text("Achieve Your Fashion Goal With Our\nInnovative Fashion App",
                              textAlign: TextAlign.center,
                              style:GoogleFonts.getFont(
                                  AppFonts.appbar,
                                  color:Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenHeight*0.018
                              ),),
                            SizedBox(height:screenHeight*0.005),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: .end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.1,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(milliseconds: 800),
                                          pageBuilder: (context, animation, secondaryAnimation) {
                                            return const Loginscreen();
                                          },
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            // Combine fade + scale + slide
                                            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
                                                CurvedAnimation(parent: animation, curve: Curves.easeOut)
                                            );

                                            final scale = Tween<double>(begin: 0.8, end: 1.0).animate(
                                                CurvedAnimation(parent: animation, curve: Curves.easeOutBack)
                                            );

                                            final slide = Tween<Offset>(
                                              begin: const Offset(0, 0.3), // slide up
                                              end: Offset.zero,
                                            ).animate(
                                                CurvedAnimation(parent: animation, curve: Curves.easeOut)
                                            );

                                            return FadeTransition(
                                              opacity: fade,
                                              child: SlideTransition(
                                                position: slide,
                                                child: ScaleTransition(
                                                  scale: scale,
                                                  child: child,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: "loginContainer",
                                      child: Container(
                                        height: screenHeight * 0.05,
                                        width: screenWidth * 0.65,
                                        decoration: BoxDecoration(
                                          color:Color(0XFF1B3C73),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Let's Get Started",
                                          style: GoogleFonts.getFont(
                                            AppFonts.contents,
                                            fontSize: screenHeight * 0.022,
                                            fontWeight: FontWeight.w500,
                                            color:Color(0XFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal:screenWidth*0.22),
                                  child: Container(
                                    height: screenHeight * 0.025,
                                    width: screenWidth * 0.9,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      boxShadow:
                                      [
                                        BoxShadow(
                                          color: Colors.lightBlue.withOpacity(0.1),
                                          blurRadius: 15,
                                          spreadRadius: 5,
                                        ),
                                        // BoxShadow(
                                        //   color: Colors.red.withOpacity(0.9),
                                        //   blurRadius: 25,
                                        //   spreadRadius: 10,
                                        // ),
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.2),
                                          blurRadius: 90,
                                          spreadRadius: 16,
                                        ),
                                      ],),
                                    child: Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        Text("New User? ",
                                          style:GoogleFonts.getFont(
                                            AppFonts.contents,
                                            fontSize:screenHeight*0.018,
                                            fontWeight: FontWeight.w500,
                                            color:Color(0XFFFF0000),
                                          ),),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration: const Duration(milliseconds: 800),
                                                pageBuilder: (context, animation, secondaryAnimation) {
                                                  return Registerscreen();
                                                },
                                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                  // Combine fade + scale + slide
                                                  final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
                                                      CurvedAnimation(parent: animation, curve: Curves.easeOut)
                                                  );

                                                  final scale = Tween<double>(begin: 0.8, end: 1.0).animate(
                                                      CurvedAnimation(parent: animation, curve: Curves.easeOutBack)
                                                  );

                                                  final slide = Tween<Offset>(
                                                    begin: const Offset(0, 0.3), // slide up
                                                    end: Offset.zero,
                                                  ).animate(
                                                      CurvedAnimation(parent: animation, curve: Curves.easeOut)
                                                  );

                                                  return FadeTransition(
                                                    opacity: fade,
                                                    child: SlideTransition(
                                                      position: slide,
                                                      child: ScaleTransition(
                                                        scale: scale,
                                                        child: child,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: "loginContainer",
                                            child: Text(" Register Now",
                                              style:GoogleFonts.getFont(
                                                AppFonts.contents,
                                                fontSize:screenHeight*0.018,
                                                fontWeight: FontWeight.w500,
                                                color:Color(0XFF124d86),
                                              ),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );


  }
}

// //BG IMAGE
// Positioned.fill(
//   child: Image.asset(
//     "assets/bgs/init7.png",
//     fit: BoxFit.cover,
//     color: Color(0XFFd93932),
//   ),
// ),
// //GET STARTED BUTTON
// Align(
//   alignment: Alignment.bottomCenter,
//   child: Padding(
//     padding: EdgeInsets.symmetric(
//       horizontal: screenWidth * 0.1,
//       vertical: screenHeight * 0.1,
//     ),
//     child: GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           PageRouteBuilder(
//             transitionDuration: const Duration(milliseconds: 800),
//             pageBuilder: (context, animation, secondaryAnimation) {
//               return const Loginscreen();
//             },
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               // Combine fade + scale + slide
//               final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
//                   CurvedAnimation(parent: animation, curve: Curves.easeOut)
//               );
//
//               final scale = Tween<double>(begin: 0.8, end: 1.0).animate(
//                   CurvedAnimation(parent: animation, curve: Curves.easeOutBack)
//               );
//
//               final slide = Tween<Offset>(
//                 begin: const Offset(0, 0.3), // slide up
//                 end: Offset.zero,
//               ).animate(
//                   CurvedAnimation(parent: animation, curve: Curves.easeOut)
//               );
//
//               return FadeTransition(
//                 opacity: fade,
//                 child: SlideTransition(
//                   position: slide,
//                   child: ScaleTransition(
//                     scale: scale,
//                     child: child,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//       child: Hero(
//         tag: "loginContainer",
//         child: Container(
//           height: screenHeight * 0.05,
//           width: screenWidth * 0.65,
//           decoration: BoxDecoration(
//             color:Color(0XFF1B3C73),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             "Let's Get Started",
//             style: GoogleFonts.gfsDidot(
//               fontSize: screenHeight * 0.022,
//               fontWeight: FontWeight.w900,
//               color:Color(0XFFFFFFFF),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),
// //TEXT FIELD-SIGN IN
// Align(
//     alignment: Alignment.bottomCenter,
//     child:Padding(
//       padding:EdgeInsets.symmetric(horizontal:screenWidth*0.22,vertical:screenHeight*0.07),
//       child: Container(
//         height: screenHeight * 0.025,
//         width: screenWidth * 0.9,
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           boxShadow:
//           [
//             BoxShadow(
//               color: Colors.lightBlue.withOpacity(0.1),
//               blurRadius: 15,
//               spreadRadius: 5,
//             ),
//             // BoxShadow(
//             //   color: Colors.red.withOpacity(0.9),
//             //   blurRadius: 25,
//             //   spreadRadius: 10,
//             // ),
//             BoxShadow(
//               color: Colors.red.withOpacity(0.2),
//               blurRadius: 90,
//               spreadRadius: 16,
//             ),
//           ],),
//         child: Row(
//           mainAxisAlignment: .center,
//           children: [
//             Text("New User? ",
//               style:GoogleFonts.gfsDidot(
//                 fontSize:screenHeight*0.018,
//                 fontWeight: FontWeight.w900,
//                 color:Color(0XFFFF0000),
//               ),),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   PageRouteBuilder(
//                     transitionDuration: const Duration(milliseconds: 800),
//                     pageBuilder: (context, animation, secondaryAnimation) {
//                       return Registerscreen();
//                     },
//                     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                       // Combine fade + scale + slide
//                       final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
//                           CurvedAnimation(parent: animation, curve: Curves.easeOut)
//                       );
//
//                       final scale = Tween<double>(begin: 0.8, end: 1.0).animate(
//                           CurvedAnimation(parent: animation, curve: Curves.easeOutBack)
//                       );
//
//                       final slide = Tween<Offset>(
//                         begin: const Offset(0, 0.3), // slide up
//                         end: Offset.zero,
//                       ).animate(
//                           CurvedAnimation(parent: animation, curve: Curves.easeOut)
//                       );
//
//                       return FadeTransition(
//                         opacity: fade,
//                         child: SlideTransition(
//                           position: slide,
//                           child: ScaleTransition(
//                             scale: scale,
//                             child: child,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//               child: Hero(
//                 tag: "loginContainer",
//                 child: Text(" Register Now",
//                   style:GoogleFonts.gfsDidot(
//                     fontSize:screenHeight*0.018,
//                     fontWeight: FontWeight.w900,
//                     color:Color(0XFF124d86),
//                   ),),
//               ),
//             )
//           ],
//         ),
//       ),
//     )
// )
//BG IMAGE