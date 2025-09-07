import 'package:flutter/material.dart';
import 'package:frontend/helpers/size_config.dart';

class CustomTextfieldHeading extends StatelessWidget {
  const CustomTextfieldHeading({super.key, required this.heading});
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.screenWidth * 0.04,
      ),
    );
  }
}
