import 'dart:io';
import 'package:derm_ai_scan/controllers/image_controller.dart';
import 'package:derm_ai_scan/controllers/profile_controller.dart';
import 'package:derm_ai_scan/controllers/scan_controller.dart';
import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/models/user.dart';
import 'package:derm_ai_scan/screens/auth/profile_screen.dart';
import 'package:derm_ai_scan/screens/menu_screen.dart';
import 'package:derm_ai_scan/screens/result_screen.dart';
import 'package:derm_ai_scan/screens/upload_bar.dart';
import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: AuthService.getUser(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return ChangeNotifierProvider<ProfileController>(
              create: (context) => ProfileController(snapshot.data!),
              child: Consumer<DiseaseController>(
                builder: (context, diseaseController, child) {
                  return Consumer<ImageController>(
                    builder: (context, imageController, child) {
                      return Dermold(
                        appBar: DermaiAppBar(
                          tit: 'Home',
                          leadingIcon: 'menu',
                          onLeading: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider<
                                    ProfileController>.value(
                                  value:
                                      Provider.of<ProfileController>(context),
                                  child: const MenuScreen(),
                                ),
                              ),
                            );
                          },
                          trailing: InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider<
                                      ProfileController>.value(
                                    value:
                                        Provider.of<ProfileController>(context),
                                    child: const ProfileScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              // padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: white,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(56),
                                child: Image.network(
                                  Provider.of<ProfileController>(context).user.picture,
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
                        ),
                        body: imageController.image != null
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        .55,
                                    padding: EdgeInsets.all(padding),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      child: Image.file(
                                        File(imageController.image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DermaiButton(
                                        onPressed: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) =>
                                                const UploadBottomSheet(),
                                          );
                                        },
                                        icon: iconify('upload'),
                                        label: 'Upload Photo',
                                        height: 50,
                                        width: 220,
                                      ),
                                      const SizedBox(height: 20),
                                      DermaiButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ResultScreen(),
                                          );
                                        },
                                        icon: iconify('scan'),
                                        label: 'Scan Photo',
                                        height: 50,
                                        width: 220,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(40),
                                        child: Text(
                                          "Unveiling the truth beneath your skin",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 19,
                                            color: mainClr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DermaiButton(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30),
                                            ),
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          context: context,
                                          builder: (context) =>
                                              const UploadBottomSheet(),
                                        );
                                      },
                                      icon: iconify('upload'),
                                      label: 'Upload Photo',
                                      height: 50,
                                      width: 210,
                                    ),
                                  ],
                                ),
                              ),
                      );
                    },
                  );
                },
              ),
            );

          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
