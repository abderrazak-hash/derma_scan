import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/contact_controller.dart';
import 'package:derm_ai_scan/controllers/profile_controller.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:derm_ai_scan/widgets/dermai_input.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dermold(
      appBar: DermaiAppBar(
        tit: 'Contact us',
        leadingIcon: 'arrow',
        titClr: black,
        onLeading: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<ProfileController>(
            builder: (context, profileController, child) {
          return Consumer<ContactController>(
            builder: (context, contactController, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DermaiInput(
                    hintText: 'Sender Email',
                    controller: contactController.emailController
                      ..text = profileController.user.email,
                  ),
                  const SizedBox(height: 15),
                  DermaiInput(
                    hintText: 'Subject',
                    controller: contactController.subjectController,
                  ),
                  const SizedBox(height: 15),
                  DermaiInput(
                    hintText: 'Mail body',
                    maxLines: 15,
                    controller: contactController.bodyController,
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 30),
                  DermaiButton(
                    onPressed: () async {
                      await contactController.sendEmail();
                    },
                    label: 'Send',
                    height: 45,
                    width: 180,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
