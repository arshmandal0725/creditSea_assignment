import 'package:flutter/material.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/models/loan_model.dart';
import 'package:frontend/widgets/custom_approval_container.dart';
import 'package:get/get.dart';
import 'package:frontend/controllers/loan_controller.dart';

class LoanStatusScreen extends StatefulWidget {
  const LoanStatusScreen({super.key, required this.loan});
  final LoanModel loan;

  @override
  State<LoanStatusScreen> createState() => _LoanStatusScreenState();
}

class _LoanStatusScreenState extends State<LoanStatusScreen> {
  final LoanController loanController = Get.put(LoanController());
  late LoanModel currentLoan;

  @override
  void initState() {
    super.initState();
    currentLoan = widget.loan;
  }

  void updateStatus() async {
    String nextStatus;

    switch (currentLoan.status) {
      case "Submitted":
        nextStatus = "Under Review";
        break;
      case "Under Review":
        nextStatus = "E-KYC";
        break;
      case "E-KYC":
        nextStatus = "E-Nach";
        break;
      case "E-Nach":
        nextStatus = "E-Sign";
        break;
      case "E-Sign":
        nextStatus = "Disbursed";
        break;
      default:
        Get.snackbar("Info", "No next step available");
        return;
    }

    try {
      bool checkPassed = true;

      if (currentLoan.id.isEmpty && currentLoan.userId.isEmpty) {
        checkPassed = false;
      }

      if (checkPassed) {
        await loanController.updateLoanStatus(currentLoan.id, nextStatus);
        Get.snackbar("Success", "Status updated to $nextStatus");
      } else {
        await loanController.updateLoanStatus(currentLoan.id, "Rejected");
        nextStatus = "Rejected";
        Get.snackbar("Failed Check", "Loan rejected due to validation");
      }

      final updatedLoan = await loanController.fetchLoanById(currentLoan.id);
      if (updatedLoan != null) {
        setState(() {
          currentLoan = updatedLoan;
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Color getStatusColor(String step) {
    if (currentLoan.status == "Rejected" && step == currentLoan.status) {
      return Colors.red;
    }

    List<String> flow = [
      "Submitted",
      "Under Review",
      "E-KYC",
      "E-Nach",
      "E-Sign",
      "Disbursed",
    ];

    int stepIndex = flow.indexOf(step);
    int currentIndex = flow.indexOf(currentLoan.status);

    if (stepIndex < currentIndex) {
      return const Color(0xFF00935D);
    }
    if (stepIndex == currentIndex) {
      return const Color(0xFF0075FF);
    }
    return const Color(0xFFB6BCC8);
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
                            'Application Status',
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.1),
                      StatusContainer(
                        color: getStatusColor("Submitted"),
                        text: "Application Submitted",
                        iconPath: 'assets/icons/notepad.png',
                      ),
                      StatusContainer(
                        color: getStatusColor("Under Review"),
                        text: "Application Under Review",
                        iconPath: 'assets/icons/notepad.png',
                      ),
                      StatusContainer(
                        color: getStatusColor("E-KYC"),
                        text: "E-KYC",
                        iconPath: 'assets/icons/notepad.png',
                      ),
                      StatusContainer(
                        color: getStatusColor("E-Nach"),
                        text: "E-Nach",
                        iconPath: 'assets/icons/notepad.png',
                      ),
                      StatusContainer(
                        color: getStatusColor("E-Sign"),
                        text: "E-Sign",
                        iconPath: 'assets/icons/notepad.png',
                      ),
                      StatusContainer(
                        color: getStatusColor("Disbursed"),
                        text: "Disbursement",
                        iconPath: 'assets/icons/notepad.png',
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.05),
                      Center(
                        child: SizedBox(
                          width: SizeConfig.screenWidth * 0.15,
                          child: Image.asset(
                            'assets/icons/hugeicons_property-view.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Application under Review",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.07,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: updateStatus,
                          child: Text(
                            'Update Loan Status',
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
                          onPressed: () {
                            Get.offNamed('/home');
                          },
                          child: Text(
                            'Continue',
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
            ),
          ],
        ),
      ),
    );
  }
}
