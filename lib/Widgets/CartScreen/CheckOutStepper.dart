import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Constants/app_fonts.dart';

class CheckoutStepper extends StatelessWidget {
  final int currentStep; // 0 = Cart, 1 = Address, 2 = Payment

  CheckoutStepper({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.02,
      ),
      child: Row(
        children: [
          _buildStep(context, "Bag", 0),
          _buildLine(context, 0),
          _buildStep(context, "Address", 1),
          _buildLine(context, 1),
          _buildStep(context, "Payment", 2),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context, String title, int step) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isActive = currentStep == step;
    bool isCompleted = currentStep > step;

    double circleSize = screenHeight * 0.022; // responsive circle
    double iconSize = circleSize * 0.5; // responsive icon

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            color: isCompleted || isActive ? Color(0XFFFF0000) : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.14,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              AppFonts.contents,
              fontSize: screenHeight * 0.015,
              fontWeight: isActive ? FontWeight.normal : FontWeight.w400,
              color: Color(0XFF0d4abc)
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLine(BuildContext context, int step) {
    final screenHeight = MediaQuery.of(context).size.height;
    bool isActive = currentStep > step;

    return Expanded(
      child: Container(
        height: screenHeight * 0.003,
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
            colors: [Color(0XFF0d4abc), Color(0XFF0d4abc)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
              : LinearGradient(
            colors: [Colors.grey.shade300, Colors.grey.shade300],
          ),
        ),
      ),
    );
  }

}
