import 'dart:developer';

import 'package:derm_ai_scan/models/user.dart';
import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupController extends ChangeNotifier {
  late TextEditingController nameController,
      phoneController,
      emailController,
      passwordController;

  SignupController() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> signup() async {
    try {
      await AuthService.signupUser(
        newUser: User(fullname: nameController.text, email: emailController.text, phone: phoneController.text, picture: ''),
        password: passwordController.value.text,
      );
      
    } catch (e) {
       log(e.toString());
    }
  }

  bool hidePswd = true;

  securePswd() {
    hidePswd = hidePswd ? false : true;
    notifyListeners();
  }
}
