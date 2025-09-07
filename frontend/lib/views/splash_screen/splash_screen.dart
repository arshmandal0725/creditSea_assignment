import 'package:flutter/material.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    Future.delayed(Duration(seconds: 2), () {
      if (token != null && token.isNotEmpty) {
        print(token);
        Get.offNamed(AppRoutes.home);
      } else {
        Get.offNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0F4B92),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.25),
              SizedBox(
                width: SizeConfig.screenWidth * 0.6,
                child: Image.asset(
                  'assets/logo/logo_vertical.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
