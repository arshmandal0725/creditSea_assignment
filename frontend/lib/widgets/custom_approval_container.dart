import 'package:flutter/material.dart';
import '../helpers/size_config.dart';

class StatusContainer extends StatelessWidget {
  final Color color;
  final String text;
  final String iconPath;

  const StatusContainer({
    super.key,
    required this.color,
    required this.text,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.05,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.02),
            border: Border.all(color: color, width: 1),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 24, height: 24, color: color),
                  SizedBox(width: SizeConfig.screenWidth * 0.2),
                ],
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: color,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Center(
          child: Container(
            height: ("Disbursement" == text)
                ? 0
                : SizeConfig.screenHeight * 0.02,
            width: 0,
            decoration: BoxDecoration(border: Border.all(color: color)),
          ),
        ),
      ],
    );
  }
}
