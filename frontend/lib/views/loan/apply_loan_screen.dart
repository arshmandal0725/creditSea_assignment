import 'package:flutter/material.dart';
import 'package:frontend/controllers/loan_controller.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/models/loan_model.dart';
import 'package:frontend/widgets/custom_purposeDropdown_textfield.dart';
import 'package:frontend/widgets/custom_textField_heading.dart';
import 'package:get/get.dart';

class ApplyLoanScreen extends StatefulWidget {
  const ApplyLoanScreen({super.key});

  @override
  State<ApplyLoanScreen> createState() => _ApplyLoanScreenState();
}

class _ApplyLoanScreenState extends State<ApplyLoanScreen> {
  final LoanController loanController = Get.put(LoanController());
  String? selectedPurpose;
  double loanAmount = 10000;
  double loanPeriod = 10;
  double totalPayable = 12000;

  void updateLoanAmount(double value) {
    setState(() {
      loanAmount = value;
      totalPayable =
          loanAmount + loanAmount * 0.1 + loanAmount * 0.01 * loanPeriod;
    });
  }

  void updateLoanPeriod(double value) {
    setState(() {
      loanPeriod = value;
      totalPayable =
          loanAmount + loanAmount * 0.1 + loanAmount * 0.01 * loanPeriod;
    });
  }

  void applyLoan() async {
    if (selectedPurpose == null || selectedPurpose!.isEmpty) {
      Get.snackbar('Error', 'Please select a loan purpose');
      return;
    }

    final LoanModel? loan = await loanController.submitLoan(
      amount: loanAmount,
      tenure: loanPeriod.toInt(),
      purpose: selectedPurpose!,
    );

    if (loan != null) {
      Get.snackbar('Success', 'Loan applied successfully');
      // Pass the created loan to the Offering screen if needed
      Get.toNamed('/offering', arguments: loan);
    } else {
      Get.snackbar('Error', 'Failed to apply for loan');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.5,
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Image.asset('assets/logo/logo_horizontal_blue.png'),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, -1),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeConfig.screenWidth * 0.07),
                    topRight: Radius.circular(SizeConfig.screenWidth * 0.07),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Icon(Icons.arrow_back),
                            onTap: () {
                              Get.back();
                            },
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.05),
                          Text(
                            'Apply for Loan',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'We’ve calculated your loan eligibility. Select your preferred loan amount and tenure.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: SizeConfig.screenWidth * 0.034,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: SizeConfig.screenHeight * 0.05,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF0075FF),
                                  width: 0.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Interest Per Day 1%',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                      255,
                                      83,
                                      83,
                                      83,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.03),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: SizeConfig.screenHeight * 0.05,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF00A676),
                                  width: 0.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Processing Fee  10%',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                      255,
                                      83,
                                      83,
                                      83,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: SizeConfig.screenHeight * 0.02),

                      const CustomTextfieldHeading(heading: "Purpose of Loan*"),
                      SizedBox(height: SizeConfig.screenHeight * 0.01),
                      LoanPurposeDropdown(
                        selectedPurpose: selectedPurpose,
                        onChanged: (value) {
                          setState(() {
                            selectedPurpose = value;
                          });
                        },
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      LoanAmountSlider(
                        value: loanAmount,
                        onChanged: updateLoanAmount,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      LoanPeriodSlider(
                        value: loanPeriod,
                        onChanged: updateLoanPeriod,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),

                      Container(
                        height: SizeConfig.screenHeight * 0.15,
                        padding: const EdgeInsets.all(3),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.05,
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF0075FF), Color(0xFF00A676)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0075FF).withOpacity(0.4),
                              offset: const Offset(0, 1),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: const Color(0xFF00A676).withOpacity(0.4),
                              offset: const Offset(0, 1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          height: SizeConfig.screenHeight * 0.1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.05 - 3,
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Principle Amount',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${loanAmount.toInt()}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF0075FF),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Interest',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '1%',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF0075FF),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Payable',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${totalPayable.toInt()}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: SizeConfig.screenWidth * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF0075FF),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      Text(
                        'Thank you for choosing CreditSea. Please accept to proceed with the loan details.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: SizeConfig.screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0075FF),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.07,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: applyLoan,
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.07,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              side: BorderSide(
                                color: const Color(0xFF0075FF),
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineThumbShape extends SliderComponentShape {
  final double thumbHeight;
  final double thumbWidth;
  final Color color;

  const LineThumbShape({
    this.thumbHeight = 24,
    this.thumbWidth = 4,
    this.color = Colors.black,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    final paint = Paint()..color = color;
    canvas.drawRect(rect, paint);
  }
}

// Loan Amount Slider
class LoanAmountSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const LoanAmountSlider({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextfieldHeading(heading: 'Principle Amount'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SizeConfig.screenWidth * 0.02,
                ),
                border: Border.all(
                  color: const Color.fromARGB(255, 227, 227, 227),
                ),
              ),
              child: Text(
                "₹ ${value.toInt()}",
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth * 0.04,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 12,
            trackShape: const RectangularSliderTrackShape(),
            thumbShape: const LineThumbShape(
              thumbHeight: 28,
              thumbWidth: 4,
              color: Color(0xFF0075FF),
            ),
            activeTrackColor: const Color(0xFF0075FF),
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: Slider(
            value: value,
            min: 10000,
            max: 200000,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// Loan Period Slider
class LoanPeriodSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const LoanPeriodSlider({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextfieldHeading(heading: 'Tenure'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SizeConfig.screenWidth * 0.02,
                ),
                border: Border.all(
                  color: const Color.fromARGB(255, 227, 227, 227),
                ),
              ),
              child: Text(
                "${value.toInt()} days",
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth * 0.04,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 12,
            trackShape: const RectangularSliderTrackShape(),
            thumbShape: const LineThumbShape(
              thumbHeight: 28,
              thumbWidth: 4,
              color: Color(0xFF0075FF),
            ),
            activeTrackColor: const Color(0xFF0075FF),
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: Slider(value: value, min: 10, max: 100, onChanged: onChanged),
        ),
      ],
    );
  }
}
