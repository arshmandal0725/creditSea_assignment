import 'package:flutter/material.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/widgets/custom_heading.dart';
import 'package:frontend/widgets/custom_textField_heading.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PersonalEmailScreen extends StatefulWidget {
  const PersonalEmailScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.marital,
  });

  final firstName;
  final lastName;
  final gender;
  final dob;
  final marital;

  @override
  State<PersonalEmailScreen> createState() => _PersonalEmailScreenState();
}

class _PersonalEmailScreenState extends State<PersonalEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomHeading(step: 1, currentStep: 2),
            CustomHeading(step: 2, currentStep: 2),
            CustomHeading(step: 3, currentStep: 2),
          ],
        ),
      ),
      body: Expanded(
        child: Container(
          height: double.infinity,
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
              topLeft: Radius.circular(SizeConfig.screenWidth * 0.1),
              topRight: Radius.circular(SizeConfig.screenWidth * 0.1),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.blueGrey.shade300,
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * 0.05),
                    Text(
                      'Personal Email Id',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: SizeConfig.screenWidth * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),

                Center(
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.6,
                    child: Image.asset(
                      'assets/images/email_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),

                const CustomTextfieldHeading(heading: "Email Id*"),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email id',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.grey,
                      fontSize: SizeConfig.screenWidth * 0.035,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: textFieldBorder, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: textFieldBorder,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: textFieldBorder, width: 1),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),

                const CustomTextfieldHeading(heading: "Enter OTP*"),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: otpController,
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: SizeConfig.screenWidth * 0.15,
                    fieldWidth: SizeConfig.screenWidth * 0.15,
                    borderRadius: BorderRadius.circular(8),
                    activeColor: const Color.fromARGB(255, 235, 235, 235),
                    selectedColor: const Color(0xFFC3C3C3),
                    inactiveColor: const Color.fromARGB(255, 235, 235, 235),
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  textStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: SizeConfig.screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Didn't receive it? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.screenWidth * 0.035,
                          fontFamily: 'Montserrat',
                        ),
                        children: [
                          TextSpan(
                            text: 'Resend Code',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "00:30",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.screenWidth * 0.035,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),

                SizedBox(
                  width: double.infinity,
                  height: SizeConfig.screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Email cannot be empty",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: Colors.white,
                        );
                        return;
                      }
                      if (otpController.text != "0000") {
                        Get.snackbar(
                          "Error",
                          "Invalid OTP",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          colorText: Colors.white,
                        );
                        return;
                      }

                      Get.toNamed(
                        '/personalPancard',
                        arguments: {
                          "firstName": widget.firstName,
                          "lastName": widget.lastName,
                          "gender": widget.gender,
                          "dob": widget.dob,
                          "marital": widget.marital,
                          "email": emailController.text,
                          "emailOtp": otpController.text,
                        },
                      );
                    },
                    child: const Text(
                      'Verify Email',
                      style: TextStyle(
                        color: Colors.white,
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
    );
  }
}
