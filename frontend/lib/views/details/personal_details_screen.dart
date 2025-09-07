import 'package:flutter/material.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/widgets/custom_datepicker.dart';
import 'package:frontend/widgets/custom_heading.dart';
import 'package:frontend/widgets/custom_textField_heading.dart';
import 'package:frontend/widgets/gender_dropdown.dart';
import 'package:frontend/widgets/marital_dropdown.dart';
import 'package:get/get.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  String? gender;
  String? marital;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final bool isIpad = SizeConfig.screenWidth > 600;
    final double textFieldFontSize = isIpad
        ? 20
        : SizeConfig.screenWidth * 0.035;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomHeading(step: 1, currentStep: 1),
            CustomHeading(step: 2, currentStep: 1),
            CustomHeading(step: 3, currentStep: 1),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 20,
            color: const Color.fromARGB(255, 243, 243, 243),
          ),
          Expanded(
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
                          'Personal Details',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomTextfieldHeading(
                                heading: "First Name*",
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.01),
                              TextField(
                                controller: firstNameController,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: textFieldFontSize,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Your first name',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: textFieldFontSize,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: textFieldBorder,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: textFieldBorder,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: textFieldBorder,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomTextfieldHeading(
                                heading: "Last Name*",
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.01),
                              TextField(
                                controller: lastNameController,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: textFieldFontSize,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Your last name',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: textFieldFontSize,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: textFieldBorder,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: textFieldBorder,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: textFieldBorder,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    const CustomTextfieldHeading(heading: "Gender*"),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    GenderDropdown(
                      selectedGender: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    const CustomTextfieldHeading(heading: "Date of Birth*"),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    DatePickerTextField(controller: dobController),

                    SizedBox(height: SizeConfig.screenHeight * 0.02),

                    const CustomTextfieldHeading(heading: "Marital Status*"),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    MaritalDropdown(
                      selectedStatus: marital,
                      onChanged: (value) {
                        setState(() {
                          marital = value;
                        });
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.07,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              gender == null ||
                              dobController.text.isEmpty ||
                              marital == null) {
                            Get.snackbar(
                              "Error",
                              "Please fill all required fields",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            Get.toNamed(
                              '/personalEmail',
                              arguments: {
                                "firstName": firstNameController.text,
                                "lastName": lastNameController.text,
                                "gender": gender,
                                "dob": dobController.text,
                                "marital": marital,
                              },
                            );
                          }
                        },
                        child: Text(
                          'Continue',
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
        ],
      ),
    );
  }
}
