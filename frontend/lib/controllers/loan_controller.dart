import 'dart:convert';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/models/loan_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanController extends GetxController {
  var isLoading = false.obs;
  var loans = <LoanModel>[].obs;

  Future<LoanModel?> submitLoan({
    required double amount,
    required int tenure,
    String? purpose,
  }) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("jwt_token");

      final response = await http.post(
        Uri.parse('$baseUrl/loan/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "amount": amount,
          "tenure": tenure,
          "purpose": purpose,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar("Success", data['message'] ?? "Loan submitted");

        if (data['loan'] != null) {
          return LoanModel.fromJson(Map<String, dynamic>.from(data['loan']));
        }
        return null;
      } else {
        Get.snackbar("Error", data['error'] ?? "Failed to submit loan");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLoans() async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("jwt_token");

      final response = await http.get(
        Uri.parse('$baseUrl/loan/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        loans.value = (data as List)
            .map((json) => LoanModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } else {
        Get.snackbar("Error", data['error'] ?? "Failed to fetch loans");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<LoanModel?> fetchLoanById(String id) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("jwt_token");

      final response = await http.get(
        Uri.parse("$baseUrl/loan/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return LoanModel.fromJson(Map<String, dynamic>.from(data));
      } else {
        Get.snackbar("Error", data['error'] ?? "Failed to fetch loan");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateLoanStatus(String loanId, String status) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("jwt_token");

      final response = await http.put(
        Uri.parse("$baseUrl/loan/$loanId/status"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"status": status}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        int index = loans.indexWhere((loan) => loan.id == loanId);
        if (index != -1) {
          loans[index].status = status;
          loans.refresh();
        }
        Get.snackbar("Success", data['message'] ?? "Status updated");
      } else {
        Get.snackbar("Error", data['message'] ?? "Failed to update status");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
