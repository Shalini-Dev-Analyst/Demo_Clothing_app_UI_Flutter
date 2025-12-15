import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/Constants/app_fonts.dart';

class AddressEdits extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String initialValue;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onUpdate;

  const AddressEdits({
    super.key,
    this.controller,
    required this.label,
    required this.initialValue,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onUpdate,
  });

  @override
  State<AddressEdits> createState() => _AddressEditsState();
}

class _AddressEditsState extends State<AddressEdits> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.getFont(
              AppFonts.contents,
              color: Color(0XFF8C8C8C),
              fontWeight: FontWeight.w400,
              fontSize: screenHeight * 0.016,
            ),
          ),
          TextFormField(
            controller: _controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            style: GoogleFonts.getFont(
              AppFonts.appbar,
              color: Colors.black,
              fontSize: screenHeight * 0.016,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF8C8C8C), width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF8C8C8C), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
