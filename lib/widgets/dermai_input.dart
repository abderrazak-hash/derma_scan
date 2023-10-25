import 'package:derm_ai_scan/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

class DermaiInput extends TextField {
  DermaiInput({
    Key? key,
    required String hintText,
    InputDecoration decorations = const InputDecoration(),
    super.controller,
    super.focusNode,
    TextInputType? keyboardType = TextInputType.text,
    super.textDirection = TextDirection.ltr,
    super.textAlign = TextAlign.left,
    super.readOnly = false,
    super.showCursor = true,
    super.autofocus = false,
    super.obscuringCharacter = '*',
    super.obscureText = false,
    super.autocorrect = true,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius = const Radius.circular(1.0),
    super.cursorColor = mainClr,
    super.selectionHeightStyle = ui.BoxHeightStyle.tight,
    super.selectionWidthStyle = ui.BoxWidthStyle.tight,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.dragStartBehavior = DragStartBehavior.start,
    super.selectionControls,
    super.onTap,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
  }) : super(
          key: key,
          decoration: decorations.copyWith(
            filled: true,
            fillColor: grey,
            hintStyle: const TextStyle(
              color: altClr,
              fontSize: 15.0,
              letterSpacing: 1.5,
            ),
            hintTextDirection: TextDirection.rtl,
            hintText: hintText,
            contentPadding: EdgeInsets.all(padding * 1.5),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          style: const TextStyle(
            color: altClr,
            fontSize: 15.0,
          ),
        );
}
