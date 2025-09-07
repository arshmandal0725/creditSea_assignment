import 'dart:convert';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> sendOtp(String phone) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("$baseUrl/auth/send-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "OTP Sent: ${data['otp']}");
        Get.toNamed("/otp", arguments: phone);
      } else {
        Get.snackbar("Error", data['error'] ?? "Failed to send OTP");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
    String? name,
    String? dob,
    String? gender,
    String? pan,
    String? email,
  }) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("$baseUrl/auth/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone": phone,
          "otp": otp,
          "name": name,
          "dob": dob,
          "gender": gender,
          "pan": pan,
          "email": email,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        Get.snackbar("Success", "OTP verified successfully");
        Future.microtask(() {
          final bool isNewUser =
              data['user']['name'] == null || data['user']['name'].isEmpty;
          if (isNewUser) {
            Get.offNamed('/personalDetails');
          } else {
            Get.offNamed('/home');
          }
        });
      } else {
        Get.snackbar("Error", data["error"] ?? "Invalid OTP");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser({
    required String name,
    required String dob,
    required String gender,
    required String pan,
    required String email,
  }) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');

      if (token == null) {
        Get.snackbar("Error", "User not authenticated");
        return;
      }

      final response = await http.post(
        Uri.parse("$baseUrl/auth/update-profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "dob": dob,
          "gender": gender,
          "pan": pan,
          "email": email,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Profile updated successfully");
        Get.offNamed('/applyLoan');
      } else {
        Get.snackbar("Error", data["error"] ?? "Failed to update profile");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel?> getUserProfile() async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');

      if (token == null) {
        Get.snackbar("Error", "User not authenticated");
        return null;
      }

      final response = await http.get(
        Uri.parse("$baseUrl/auth/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to fetch user profile");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
