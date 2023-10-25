import 'dart:developer';

import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late TextEditingController emailController, passwordController;

  LoginController() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> login() async {
    try {
      await AuthService.loginUser(
        email: emailController.value.text,
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
