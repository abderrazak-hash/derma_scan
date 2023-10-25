import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/signup_controller.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:derm_ai_scan/widgets/dermai_input.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dermold(
      appBar: DermaiAppBar(
        tit: 'Signup',
        leadingIcon: 'arrow',
        onLeading: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Consumer<SignupController>(
            builder: (context, signupController, child) {
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
                controller: signupController.nameController,
                hintText: 'Full name',
              ),
              const SizedBox(height: 15),
              DermaiInput(
                controller: signupController.emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 15),
              DermaiInput(
                controller: signupController.phoneController,
                hintText: 'Phone',
              ),
              const SizedBox(height: 15),
              DermaiInput(
                controller: signupController.passwordController,
                hintText: 'Password',
                obscureText: signupController.hidePswd,
                decorations: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      signupController.securePswd();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        iconify(signupController.hidePswd ? 'hide' : 'show'),
                        height: 18,
                        width: 18,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              DermaiButton(
                onPressed: () {
                  signupController
                      .signup()
                      .then((value) => Navigator.pop(context));
                },
                label: 'Signup',
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
