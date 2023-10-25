import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController extends ChangeNotifier {
  late TextEditingController emailController;

  ForgetPasswordController() {
    emailController = TextEditingController(text: '');
  }

  Future<void> forgetPassword() async {
    await AuthService.forgetPassword(emailController.text);
  }
}
