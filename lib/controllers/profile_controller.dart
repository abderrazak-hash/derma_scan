import 'dart:developer';

import 'package:derm_ai_scan/models/user.dart' as usr;
import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {
  late usr.User user;
  String updatedImage = '';

  late TextEditingController nameController,
      phoneController,
      emailController,
      passwordController;

  ProfileController(usr.User myUser) {
    user = myUser;
    nameController = TextEditingController(text: user.fullname);
    phoneController = TextEditingController(text: user.phone);
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController();
  }

  Future<void> logout() async {
    try {
      await AuthService.logoutUser();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateUser() async {
    user.fullname = nameController.text;
    user.phone = phoneController.text;
    try {
      if (updatedImage != '') {
        try {

        user.picture = await AuthService.updateUserPicture(updatedImage);
        } catch (e) {
        }
      }
      await AuthService.updateUser(user);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickUserImage() async {
    final ImagePicker imagePicker = ImagePicker();

    final res = await imagePicker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      updatedImage = res.path;
    }
  }
}
