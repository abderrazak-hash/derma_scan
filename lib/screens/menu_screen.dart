import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/profile_controller.dart';
import 'package:derm_ai_scan/screens/auth/profile_screen.dart';
import 'package:derm_ai_scan/screens/contact_screen.dart';
import 'package:derm_ai_scan/screens/history_screen.dart';
import 'package:derm_ai_scan/services/auth_service.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
        builder: (context, profileController, child) {
      return Dermold(
        appBar: DermaiAppBar(
          tit: 'Menu',
          titClr: white,
          leadingIcon: 'arrow',
          onLeading: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: mainClr,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Container(
                  height: 72,
                  width: 72,
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileController.user.fullname,
                      style: const TextStyle(
                        color: white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      profileController.user.email,
                      style: const TextStyle(
                        color: white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              iconify('user'),
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
              color: white,
            ),
            title: const Text(
              'My Profile',
              style: TextStyle(
                color: white,
                fontSize: 22,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ChangeNotifierProvider<ProfileController>.value(
                    value: Provider.of<ProfileController>(context),
                    child: const ProfileScreen(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              iconify('user'),
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
              color: white,
            ),
            title: const Text(
              'My History',
              style: TextStyle(
                color: white,
                fontSize: 22,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ChangeNotifierProvider<ProfileController>.value(
                    value: Provider.of<ProfileController>(context),
                    child: HistoryScreen(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              iconify('phone'),
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
              color: white,
            ),
            title: const Text(
              'Contact Us',
              style: TextStyle(
                color: white,
                fontSize: 22,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ChangeNotifierProvider<ProfileController>.value(
                    value: Provider.of<ProfileController>(context),
                    child: const ContactScreen(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              iconify('logout'),
              height: 30,
              width: 30,
              fit: BoxFit.scaleDown,
              color: white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: white,
                fontSize: 22,
              ),
            ),
            onTap: () async {
              await AuthService.logoutUser().then(
                (value) => Navigator.pop(context),
              );
            },
          ),
        ]),
      );
    });
  }
}
