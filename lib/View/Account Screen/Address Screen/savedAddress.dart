import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_colors.dart';
import 'package:s_apparels_clothes/Utils/Constants/app_fonts.dart';
import '../../../Widgets/AccountScreen/AddressScreen/SavedAddressFields.dart';
import '../AccountScreen.dart';
import 'addAddress.dart';


class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  List<Map<String, dynamic>> savedAddresses = [];
  String customerAccessToken = '';

  @override
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
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
                Text("Saved Address",
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
          Expanded(
            child: savedAddresses.isEmpty
                ? Center(
              child: Text(
                "No Address Saved",
                style: GoogleFonts.getFont(
                  AppFonts.body,
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.w500,
                  color:AppColors.pagesubtext,
                ),
              ),
            )
                : ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              itemCount: savedAddresses.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final address = savedAddresses[index];
                return SavedAddress(
                  type: address['type']!,
                  icon: address['icon'] != null
                      ? address['icon'] as IconData
                      : Icons.location_on,
                  apartment: address['apartment']!,
                  flat: address['flat']!,
                  landmark: address['landmark']!,
                  city: address['city']!,
                  mobile: address['mobile']!,
                  addressId: address['addressId']!,
                  customerAccessToken: address['customerAccessToken']!,
                  onDelete: (){},
                  onEdit: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddAddressScreen(
                          type: address['type']!,
                          icon: address['icon'] != null
                              ? address['icon'] as IconData
                              : Icons.location_on,
                          apartment: address['apartment']!,
                          flat: address['flat']!,
                          landmark: address['landmark']!,
                          city: address['city']!,
                          mobile: address['mobile']!,
                          addressId: address['addressId']!,
                          customerAccessToken:
                          address['customerAccessToken']!,
                        ),
                      ),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      final index = savedAddresses.indexWhere((a) => a['addressId'] == result['addressId']);
                      if (index != -1) {
                        setState(() {
                          savedAddresses[index] = result;
                        });
                      }
                    }

                  },
                  onSetDefault: (){},
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddAddressScreen()),
                  );

                  if (result != null && result is Map<String, dynamic>) {
                    //Add the newly returned address to the list immediately
                    setState(() {
                      savedAddresses.insert(0, result); // insert at top of list
                    });
                  }
                },

                child: Container(
                  height: screenHeight * 0.05,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.pink.shade300,
                  ),
                  child: Center(
                    child: Text(
                      "Add Or Choose Address",
                      style: GoogleFonts.getFont(
                        AppFonts.contents,
                        fontWeight: FontWeight.w500,
                        fontSize: screenHeight * 0.018,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
