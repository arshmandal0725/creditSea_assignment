import 'dart:ui';

Color primaryColor = const Color(0xFF0F4B92);
Color textFieldBorder = const Color(0xFFC3C3C3);

const String host = "192.168.1.10";
const int port = 8000;
String baseUrl = "http://$host:$port";

class ApiEndpoints {
  static String sendOtp = "$baseUrl/auth/send-otp";
  static String verifyOtp = "$baseUrl/auth/verify-otp";
}
