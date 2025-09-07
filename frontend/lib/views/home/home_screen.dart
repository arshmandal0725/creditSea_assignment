import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/loan_controller.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoanController loanController = Get.put(LoanController());
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());

  late UserModel? currentUser = UserModel(id: '', phone: '', name: 'User');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUser();
    });
  }

  Future<void> fetchUser() async {
    currentUser = await authController.getUserProfile();
    if (currentUser != null) {
      userController.setUser(currentUser!);
    }
    await loanController.fetchLoans();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.1,
              child: Image.asset('assets/logo/logo_vertical.png'),
            ),
            SizedBox(width: 20),
            Text(
              'Welcome, ${currentUser?.name ?? 'User'}',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: SizeConfig.screenWidth * 0.035,
              ),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Get.toNamed('/applyLoan');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: logout,
          ),
        ],
      ),
      body: Obx(() {
        if (loanController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(SizeConfig.screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (loanController.loans.isEmpty)
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.3),
                      const Icon(
                        Icons.add_circle_outline,
                        size: 50,
                        color: Colors.blue,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      Text(
                        'No loans found.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: SizeConfig.screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ...loanController.loans.map((loan) {
                Color statusColor;
                switch (loan.status) {
                  case "Submitted":
                  case "Under Review":
                  case "E-KYC":
                  case "E-Nach":
                  case "E-Sign":
                    statusColor = Colors.blue;
                    break;
                  case "Disbursed":
                    statusColor = Colors.green;
                    break;
                  case "Rejected":
                    statusColor = Colors.red;
                    break;
                  default:
                    statusColor = Colors.grey;
                }

                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.screenHeight * 0.01,
                  ),
                  child: ListTile(
                    onTap: () {
                      if (loan.status == "Disbursed") {
                        Get.toNamed('/loanRepay', arguments: loan);
                      } else {
                        Get.toNamed('/loanStatus', arguments: loan);
                      }
                    },
                    title: Text(
                      'Loan #${loan.id}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Amount: ₹${loan.amount.toInt()} | Status: ${loan.status}',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: statusColor,
                      radius: 10,
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Text(
                'Click on the + button to apply for a new loan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: SizeConfig.screenWidth * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
