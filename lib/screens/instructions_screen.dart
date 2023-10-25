import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/services/medical_instrcutions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      actionsPadding: const EdgeInsets.symmetric(vertical: 30),
      titlePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Medical Instructions',
            style: TextStyle(
              fontSize: 20,
              color: mainClr,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              iconify('close'),
              width: 20,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              '${index + 1} - ${medicalInstructions[index]}',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}
