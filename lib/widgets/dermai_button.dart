import 'package:derm_ai_scan/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DermaiButton extends TextButton {
  DermaiButton({
    Key? key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.antiAlias,
    double? height, // = 40,
    double? width, // = 180,
    String label = '',
    String? icon,
  }) : super(
          key: key,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
          ),
          child: Container(
            height: height,
            width: width,
            // padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: mainClr,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  SvgPicture.asset(
                    icon,
                    color: white,
                    height: 30,
                    width: 30,
                    fit: BoxFit.scaleDown,
                  ),
                if (icon != null) const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        );
}
