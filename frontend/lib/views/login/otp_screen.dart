import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  OtpScreen({super.key, required this.phone});

  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _otpController = TextEditingController();

  double _responsiveFont(double base) {
    return (SizeConfig.screenWidth * base).clamp(12.0, 20.0);
  }

  double _responsiveImage(double base, {double? min, double? max}) {
    return (SizeConfig.screenWidth * base).clamp(min ?? 100.0, max ?? 220.0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _responsiveImage(0.6, max: 220),
                    child: Image.asset('assets/logo/logo_horizontal.png'),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),

                  SizedBox(
                    width: _responsiveImage(0.45, max: 180),
                    child: Image.asset('assets/images/lightening_doc.png'),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),

                  Text(
                    'Instant Loan Approval',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: _responsiveFont(0.05),
                    ),
                  ),
                  Text(
                    'Users will receive approval within minutes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: _responsiveFont(0.03),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                      Container(
                        width: SizeConfig.screenWidth * 0.012,
                        height: SizeConfig.screenWidth * 0.012,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.03,
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                      Container(
                        width: SizeConfig.screenWidth * 0.06,
                        height: SizeConfig.screenWidth * 0.012,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.screenWidth * 0.1),
                  topRight: Radius.circular(SizeConfig.screenWidth * 0.1),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.blueGrey.shade300,
                        ),
                      ),
                      SizedBox(
                        width: isIpad
                            ? SizeConfig.screenWidth * 0.35
                            : SizeConfig.screenWidth * 0.2,
                      ),
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: _responsiveFont(0.05),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Verify OTP, Sent on ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: _responsiveFont(0.035),
                          ),
                        ),
                        TextSpan(
                          text: phone,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: _responsiveFont(0.035),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),

                  isIpad
                      ? SizedBox(
                          width: SizeConfig.screenWidth * 0.5,
                          child: PinCodeTextField(
                            controller: _otpController,
                            appContext: context,
                            length: 4,
                            onChanged: (value) {},
                            keyboardType: TextInputType.number,
                            enableActiveFill: true,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldHeight: isIpad
                                  ? 60
                                  : SizeConfig.screenWidth * 0.15,
                              fieldWidth: isIpad
                                  ? 50
                                  : SizeConfig.screenWidth * 0.15,
                              borderRadius: BorderRadius.circular(8),
                              activeColor: const Color(0xFFC3C3C3),
                              selectedColor: const Color(0xFFC3C3C3),
                              inactiveColor: const Color(0xFFC3C3C3),
                              activeFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.grey.shade100,
                            ),
                            textStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : PinCodeTextField(
                          controller: _otpController,
                          appContext: context,
                          length: 4,
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                          enableActiveFill: true,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: isIpad
                                ? 60
                                : SizeConfig.screenWidth * 0.15,
                            fieldWidth: isIpad
                                ? 50
                                : SizeConfig.screenWidth * 0.15,
                            borderRadius: BorderRadius.circular(8),
                            activeColor: const Color(0xFFC3C3C3),
                            selectedColor: const Color(0xFFC3C3C3),
                            inactiveColor: const Color(0xFFC3C3C3),
                            activeFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            inactiveFillColor: Colors.grey.shade100,
                          ),
                          textStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: SizeConfig.screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),

                  const Spacer(),

                  Row(
                    children: [
                      const SizedBox(width: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Resend OTP in ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: _responsiveFont(0.035),
                              ),
                            ),
                            TextSpan(
                              text: '00:30',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: _responsiveFont(0.035),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),

                  Obx(
                    () => SizedBox(
                      height: SizeConfig.screenHeight * 0.065,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: _authController.isLoading.value
                            ? null
                            : () async {
                                await Future.delayed(Duration.zero);
                                _authController.verifyOtp(
                                  phone: phone,
                                  otp: _otpController.text,
                                );
                              },
                        child: _authController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Verify',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: _responsiveFont(0.035),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
