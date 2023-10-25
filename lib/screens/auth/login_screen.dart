import 'package:derm_ai_scan/controllers/image_controller.dart';
import 'package:derm_ai_scan/controllers/login_controller.dart';
import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/screens/auth/forget_password_screen.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:derm_ai_scan/widgets/dermai_input.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dermold(
      appBar: DermaiAppBar(
        tit: 'Login',
        leadingIcon: 'arrow',
        onLeading: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Consumer<LoginController>(
            builder: (context, loginController, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    imagify("g-dermai"),
                  ),
                ),
              ),
              DermaiInput(
                controller: loginController.emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 15),
              DermaiInput(
                controller: loginController.passwordController,
                hintText: 'Password',
                obscureText: loginController.hidePswd,
                decorations: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      loginController.securePswd();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        iconify(loginController.hidePswd ? 'hide' : 'show'),
                        height: 18,
                        width: 18,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ForgetPasswordScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: mainClr,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DermaiButton(
                onPressed: () async {
                  await loginController.login().then(
                        (value) => Navigator.pop(context),
                      );
                },
                label: 'Login',
                height: 45,
                width: 180,
              ),
              const SizedBox(
                height: 120,
              ),
            ],
          );
        }),
      ),
    );
  }
}
