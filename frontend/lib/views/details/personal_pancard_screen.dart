import 'package:flutter/material.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/widgets/custom_heading.dart';
import 'package:frontend/widgets/custom_textField_heading.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class PersonalPancardScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String gender;
  final String dob;
  final String marital;
  final String email;

  const PersonalPancardScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.marital,
    required this.email,
  });

  @override
  State<PersonalPancardScreen> createState() => _PersonalPancardScreenState();
}

class _PersonalPancardScreenState extends State<PersonalPancardScreen> {
  final TextEditingController panController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

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
            CustomHeading(step: 1, currentStep: 3),
            CustomHeading(step: 2, currentStep: 3),
            CustomHeading(step: 3, currentStep: 3),
          ],
        ),
      ),
      body: Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
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
                      'Verify PAN Number',
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
                      'assets/images/pancard_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),

                const CustomTextfieldHeading(heading: "Enter your PAN Number*"),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                TextField(
                  controller: panController,
                  decoration: InputDecoration(
                    hintText: 'ex. ABCDE1234F',
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

                SizedBox(height: SizeConfig.screenHeight * 0.35),

                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: SizeConfig.screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : () async {
                              if (panController.text.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "PAN number cannot be empty",
                                );
                                return;
                              }

                              authController.updateUser(
                                name: "${widget.firstName} ${widget.lastName}",
                                dob: widget.dob,
                                gender: widget.gender,
                                email: widget.email,
                                pan: panController.text,
                              );

                              if (!authController.isLoading.value) {
                                Get.offNamed('/applyLoan');
                              }
                            },
                      child: authController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Verify PAN',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
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
