import 'package:derm_ai_scan/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DermaiAppBar extends AppBar {
  DermaiAppBar({
    super.key,
    String tit = '',
    Color titClr = mainClr,
    String leadingIcon = '',
    Function()? onLeading,
    Widget? trailing,
    super.automaticallyImplyLeading = true,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.scrolledUnderElevation,
    super.notificationPredicate = defaultScrollNotificationPredicate,
    super.shadowColor = Colors.transparent,
    super.surfaceTintColor,
    super.shape,
    super.backgroundColor = Colors.transparent,
    super.foregroundColor = Colors.transparent,
  }) : super(
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: InkWell(
                onTap: onLeading,
                child: SvgPicture.asset(
                  iconify(leadingIcon),
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                  color: titClr,
                ),
              ),
            ),
            title: Text(
              tit,
              style: TextStyle(
                fontSize: 20,
                color: titClr,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10),
                child: trailing ??
                    const SizedBox(
                      width: 50,
                    ),
              ),
            ]);
}
