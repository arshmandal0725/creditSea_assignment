import 'package:get/get.dart';
import 'package:frontend/models/user_model.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  Rxn<UserModel> currentUser = Rxn<UserModel>();

  void setUser(UserModel user) {
    currentUser.value = user;
  }

  UserModel? get user => currentUser.value;
}
