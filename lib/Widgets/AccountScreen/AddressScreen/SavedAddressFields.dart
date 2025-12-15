import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';


class SavedAddress extends StatelessWidget {
  final String type;
  final IconData icon;
  final String apartment;
  final String flat;
  final String landmark;
  final String city;
  final String mobile;
  final String addressId;
  final String customerAccessToken;

  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onSetDefault;

  const SavedAddress({
    super.key,
    required this.type,
    required this.icon,
    required this.apartment,
    required this.flat,
    required this.landmark,
    required this.city,
    required this.mobile,
    required this.addressId,
    required this.customerAccessToken,
    this.onDelete,
    this.onEdit,
    this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
      child: Container(
        padding: EdgeInsets.all(screenHeight * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: screenHeight * 0.025, color: Colors.red),
                const SizedBox(width: 6),
                Text(
                  type,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: screenHeight * 0.016,
                    fontWeight: FontWeight.bold,
                    color:AppColors.pagesubtext
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    switch (value) {
                      case 'default':
                        if (onSetDefault != null) onSetDefault!();
                        break;
                      case 'edit':
                        if (onEdit != null) onEdit!();
                        break;
                      case 'delete':
                        if (onDelete != null) onDelete!();
                        break;
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  elevation: 4,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'default',
                      child: Row(
                        children: [
                          const Icon(Icons.star_border, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            'Set as Default',
                            style: GoogleFonts.jost(fontSize: screenHeight * 0.014),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit, size: 18),
                          const SizedBox(width: 10),
                          Text(
                            'Edit',
                            style: GoogleFonts.jost(fontSize: screenHeight * 0.014),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                          const SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: GoogleFonts.jost(
                              fontSize: screenHeight * 0.014,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  icon: Icon(
                    Icons.more_vert,
                    size: screenHeight * 0.025,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "$apartment, $flat${landmark.isNotEmpty ? ', $landmark' : ''}, $city",
              style: GoogleFonts.jost(
                fontSize: screenHeight * 0.014,
                color: const Color(0XFF8F8A8A),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              "Phone Number: $mobile",
              style: GoogleFonts.jost(
                fontSize: screenHeight * 0.014,
                color: const Color(0XFF8F8A8A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





