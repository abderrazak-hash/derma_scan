import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/profile_controller.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:derm_ai_scan/widgets/dermai_input.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dermold(
      appBar: DermaiAppBar(
        tit: 'Edit Profile',
        leadingIcon: 'arrow',
        titClr: black,
        onLeading: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Consumer<ProfileController>(
          builder: (context, profileController, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 120,
                  width: 130,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: mainClr,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(56),
                            child: Image.network(
                              profileController.user.picture,
                              fit: BoxFit.cover,
                              errorBuilder: (context, _, __) {
                                return Image.asset(
                                  imagify('profile'),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            await profileController.pickUserImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: mainClr,
                              ),
                            ),
                            child: SvgPicture.asset(
                              iconify('camera'),
                              height: 25,
                              color: mainClr,
                              width: 25,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DermaiInput(
                      hintText: 'Full name',
                      controller: profileController.nameController,
                    ),
                    const SizedBox(height: 15),
                    DermaiInput(
                      hintText: 'Email',
                      controller: profileController.emailController,
                    ),
                    const SizedBox(height: 15),
                    DermaiInput(
                      hintText: 'Phone',
                      controller: profileController.phoneController,
                    ),
                    const SizedBox(height: 15),
                    // DermaiInput(
                    //   hintText: 'Password',
                    //   controller: profileController.passwordController,
                    //   obscureText: true,
                    //   decorations: InputDecoration(
                    //     suffix: InkWell(
                    //       onTap: () {},
                    //       child: SvgPicture.asset(
                    //         iconify('eye'),
                    //         height: 18,
                    //         fit: BoxFit.fitHeight,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                    DermaiButton(
                      onPressed: () {
                        profileController.updateUser();
                      },
                      label: 'Update',
                      height: 45,
                      width: 180,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            );
          },
        ),
      ),
    );
  }
}
