import 'package:flutter/material.dart';
import '../helpers/size_config.dart';

class CustomHeading extends StatelessWidget {
  final int step;
  final int currentStep;

  CustomHeading({required this.step, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final Map<int, String> stepLabels = {
      1: 'Details',
      2: 'Email',
      3: 'PAN Card',
    };

    final Color circleColor = step == currentStep
        ? Color(0xFF0075FF)
        : Colors.grey.shade400;
    final Color textColor = step == currentStep
        ? Color(0xFF0075FF)
        : Colors.grey.shade600;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.04,
          height: SizeConfig.screenWidth * 0.04,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.screenWidth * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(width: SizeConfig.screenWidth * 0.01),

        Text(
          stepLabels[step] ?? '',
          style: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.03,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
