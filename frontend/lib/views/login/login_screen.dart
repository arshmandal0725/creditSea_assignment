import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isChecked = false;
  final TextEditingController phoneController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  String countryCode = '+91';

  double _responsiveFont(double base) {
    return (SizeConfig.screenWidth * base).clamp(12.0, 20.0);
  }

  double _responsiveImage(double base, {double? min, double? max}) {
    return (SizeConfig.screenWidth * base).clamp(min ?? 100.0, max ?? 250.0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

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
                    child: Image.asset('assets/images/utils_grid.png'),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),

                  Text(
                    'Flexible Loan Options',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: _responsiveFont(0.05),
                    ),
                  ),
                  Text(
                    'Loan types to cater to different financial needs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: _responsiveFont(0.03),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Credit Sea!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: _responsiveFont(0.05),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),

                  Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: _responsiveFont(0.03),
                    ),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: textFieldBorder, width: 1),
                          borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.02,
                          ),
                        ),
                        child: CountryCodePicker(
                          onChanged: (country) {
                            countryCode = country.dialCode ?? '+91';
                          },
                          initialSelection: 'IN',
                          favorite: ['+91', 'US'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.03),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: _responsiveFont(0.035)),
                          decoration: InputDecoration(
                            hintText: 'Please enter your mobile no.',
                            hintStyle: TextStyle(
                              color: textFieldBorder,
                              fontWeight: FontWeight.bold,
                              fontSize: _responsiveFont(0.03),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.03,
                              vertical: SizeConfig.screenHeight * 0.018,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 0.02,
                              ),
                              borderSide: BorderSide(
                                color: textFieldBorder,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 0.02,
                              ),
                              borderSide: BorderSide(
                                color: textFieldBorder,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.screenWidth * 0.02,
                              ),
                              borderSide: BorderSide(
                                color: textFieldBorder,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.06,
                        height: SizeConfig.screenWidth * 0.06,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: textFieldBorder, width: 1),
                          ),
                          activeColor: const Color(0xFF00A676),
                          checkColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                      Expanded(
                        child: Text(
                          'By continuing, you agree to our privacy policies and Terms & Conditions.',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: _responsiveFont(0.025),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),

                  Obx(() {
                    return SizedBox(
                      height: SizeConfig.screenHeight * 0.065,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: isChecked == true
                            ? () {
                                authController.sendOtp(
                                  phoneController.text.trim(),
                                );
                              }
                            : null,
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Request OTP',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: _responsiveFont(0.035),
                                ),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
