import 'package:derm_ai_scan/controllers/forget_password_controller.dart';
import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:derm_ai_scan/widgets/dermai_input.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dermold(
      appBar: DermaiAppBar(
        tit: 'Forget Password',
        leadingIcon: 'arrow',
        onLeading: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Consumer<ForgetPasswordController>(
            builder: (context, forgetPasswordController, child) {
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
                controller: forgetPasswordController.emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 45),
              DermaiButton(
                onPressed: () async {
                  await forgetPasswordController.forgetPassword().then((value) {
                    SnackBar snackBar = const SnackBar(
                      content:
                          Text('A reset-password mail has been sent to you'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                label: 'Reset Password',
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
