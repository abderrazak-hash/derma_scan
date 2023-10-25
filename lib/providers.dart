import 'package:derm_ai_scan/controllers/contact_controller.dart';
import 'package:derm_ai_scan/controllers/forget_password_controller.dart';
import 'package:derm_ai_scan/controllers/history_controller.dart';
import 'package:derm_ai_scan/controllers/login_controller.dart';
import 'package:derm_ai_scan/controllers/image_controller.dart';
import 'package:derm_ai_scan/controllers/scan_controller.dart';
import 'package:derm_ai_scan/controllers/signup_controller.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<LoginController>(
    create: (context) => LoginController(),
  ),
  ChangeNotifierProvider<SignupController>(
    create: (context) => SignupController(),
  ),
  ChangeNotifierProvider<ForgetPasswordController>(
    create: (context) => ForgetPasswordController(),
  ),
  ChangeNotifierProvider<ImageController>(
    create: (context) => ImageController(),
  ),
  ChangeNotifierProvider<DiseaseController>(
    create: (context) => DiseaseController(),
  ),
  ChangeNotifierProvider<ContactController>(
    create: (context) => ContactController(),
  ),
  ChangeNotifierProvider<HistoryController>(
    create: (context) => HistoryController(),
  ),
];
