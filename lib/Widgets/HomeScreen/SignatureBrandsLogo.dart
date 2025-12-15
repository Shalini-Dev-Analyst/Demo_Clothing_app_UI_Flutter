import 'package:flutter/material.dart';

class Signaturebrandslogo extends StatefulWidget {
  final String img;
  const Signaturebrandslogo({super.key,required this.img});

  @override
  State<Signaturebrandslogo> createState() => _SignaturebrandslogoState();
}

class _SignaturebrandslogoState extends State<Signaturebrandslogo> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height:h*0.1,
      width:w*0.5,
      child: Image.asset(widget.img),
    );
  }
}
