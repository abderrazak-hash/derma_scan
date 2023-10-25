import 'dart:math';

import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/image_controller.dart';
import 'package:derm_ai_scan/controllers/scan_controller.dart';
import 'package:derm_ai_scan/screens/instructions_screen.dart';
import 'package:derm_ai_scan/screens/loading_screen.dart';
import 'package:derm_ai_scan/widgets/dermai_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiseaseController>(
        builder: (context, diseaseController, child) {
      return Consumer<ImageController>(
          builder: (context, imageController, child) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: Provider.of<DiseaseController>(context)
              .classifyDisease(Provider.of<ImageController>(context).image!),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const LoadingScreen();

              case ConnectionState.active:
                return const LoadingScreen();

              case ConnectionState.waiting:
                return const LoadingScreen();
              case ConnectionState.done:
                List<Map<String, dynamic>> results = snapshot.data!;
                print(results);
                return AlertDialog(
                  backgroundColor: white,
                  actionsPadding: const EdgeInsets.symmetric(vertical: 30),
                  titlePadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Result',
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
                      min(3, results.length),
                      (index) => Column(
                        children: [
                          Text(results[index]['label']),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: LinearPercentIndicator(
                              width: 170.0,
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 10.0,
                              trailing:
                                  Text('${results[index]['confidence']} %'),
                              percent: results[index]['confidence'] / 100,
                              barRadius: const Radius.circular(5),
                              progressColor: mainClr,
                              backgroundColor: grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DermaiButton(
                            width: 110,
                            height: 50,
                            onPressed: () async {
                              await diseaseController.saveResult(
                                  imageController.image!, results);
                            },
                            label: 'Save',
                          ),
                          DermaiButton(
                            width: 110,
                            height: 50,
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) => const InstructionScreen(),
                              );
                            },
                            label: 'Advice',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
            }
          },
        );
      });
    });
  }
}
