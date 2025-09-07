import 'package:flutter/material.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/models/loan_model.dart';
import 'package:frontend/widgets/custom_textField_heading.dart';
import 'package:get/get.dart';
import 'package:frontend/controllers/loan_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class LoanRepaymentScreen extends StatefulWidget {
  const LoanRepaymentScreen({super.key, required this.loan});
  final LoanModel loan;

  @override
  State<LoanRepaymentScreen> createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  final LoanController loanController = Get.put(LoanController());
  final user = UserController.instance.user;

  late double sliderValue;
  late Razorpay _razorpay;

  LoanModel get currentLoan => widget.loan;

  @override
  void initState() {
    super.initState();
    sliderValue = 1;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Payment Success", "Payment ID: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "${response.code}: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", "Wallet Name: ${response.walletName}");
  }

  void _payWithRazorpay() {
    var options = {
      'key': 'rzp_test_RDXBbUKGZ0J1aa',
      'amount': (sliderValue * 100).toInt(),
      'name': 'Your App Name',
      'description': 'Loan Repayment',
      'prefill': {'contact': user!.phone},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: const Icon(Icons.arrow_back),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 0.05),
                        Text(
                          'Active Loan',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.005),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: SizeConfig.screenWidth * 0.03,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: 'Loan application no. '),
                          TextSpan(
                            text: '#${currentLoan.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Text(
                      'Total amount to Pay is ${currentLoan.amount.toInt()}',
                      style: TextStyle(
                        fontFamily: 'MONTSERRAT',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Text(
                      'Total Period is ${currentLoan.tenure.toInt()} days',
                      style: TextStyle(
                        fontFamily: 'MONTSERRAT',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                    LoanAmountSlider(
                      value: sliderValue,
                      onChanged: (val) {
                        setState(() {
                          sliderValue = val;
                        });
                      },
                      min: 1,
                      max: currentLoan.amount.toDouble(),
                    ),

                    Spacer(),

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.065,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _payWithRazorpay,
                        child: Text(
                          'Repay',
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
                      height: SizeConfig.screenHeight * 0.065,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color(0xFF0075FF),
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
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
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoanAmountSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  const LoanAmountSlider({
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
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
            const CustomTextfieldHeading(heading: 'Repay Amount'),
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
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
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
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(thumbWidth, thumbHeight);

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
