import 'package:frontend/models/loan_model.dart';
import 'package:frontend/views/details/personal_details_screen.dart';
import 'package:frontend/views/details/personal_email.dart';
import 'package:frontend/views/details/personal_pancard_screen.dart';
import 'package:frontend/views/home/home_screen.dart';
import 'package:frontend/views/loan/repayment_screen.dart';
import 'package:frontend/views/loan/apply_loan_screen.dart';
import 'package:frontend/views/loan/loan_status_screen.dart';
import 'package:frontend/views/loan/offering_screen.dart';
import 'package:frontend/views/login/login_screen.dart';
import 'package:frontend/views/login/otp_screen.dart';
import 'package:frontend/views/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const otp = '/otp';
  static const loan = '/loan';
  static const personalDetails = '/personalDetails';
  static const personalEmail = '/personalEmail';
  static const personalPancard = '/personalPancard';
  static const applyLoan = '/applyLoan';
  static const offering = '/offering';
  static const loanStatus = '/loanStatus';
  static const loanRepay = '/loanRepay';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(
      name: otp,
      page: () {
        final phone = Get.arguments as String;
        return OtpScreen(phone: phone);
      },
    ),
    GetPage(name: personalDetails, page: () => PersonalDetailsScreen()),
    GetPage(
      name: personalEmail,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return PersonalEmailScreen(
          firstName: args["firstName"],
          lastName: args["lastName"],
          gender: args["gender"],
          dob: args["dob"],
          marital: args["marital"],
        );
      },
    ),
    GetPage(
      name: personalPancard,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return PersonalPancardScreen(
          firstName: args["firstName"],
          lastName: args["lastName"],
          gender: args["gender"],
          dob: args["dob"],
          marital: args["marital"],
          email: args["email"],
        );
      },
    ),
    GetPage(
      name: offering,
      page: () => OfferingScreen(loan: Get.arguments as LoanModel),
    ),
    GetPage(
      name: loanStatus,
      page: () => LoanStatusScreen(loan: Get.arguments as LoanModel),
    ),

    GetPage(
      name: loanRepay,
      page: () => LoanRepaymentScreen(loan: Get.arguments as LoanModel),
    ),

    GetPage(name: applyLoan, page: () => ApplyLoanScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
