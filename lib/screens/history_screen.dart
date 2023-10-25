import 'dart:math';

import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/history_controller.dart';
import 'package:derm_ai_scan/models/history_element.dart';
import 'package:derm_ai_scan/services/dataset_service.dart';
import 'package:derm_ai_scan/widgets/dermai_appbar.dart';
import 'package:derm_ai_scan/widgets/dermold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  List<Map<String, dynamic>> results = [
    {"label": "14  Angioma", "confidence": 83.11},
    {"label": "134 Nevus_Spilus", "confidence": 11.39}
  ];

  @override
  Widget build(BuildContext context) {
    DatasetService.getHistory();
    return Dermold(
      appBar: DermaiAppBar(
        tit: 'My History',
        leadingIcon: 'arrow',
        titClr: black,
        onLeading: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<HistoryController>(
            builder: (context, historyController, child) {
          return FutureBuilder(
              future: historyController.loadHistory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<HistoryElement> history = snapshot.data!;
                  return ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (HistoryElement element in history)
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: grey,
                          ),
                          child: Row(
                            
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 80,
                                    maxHeight: 200,
                                  ),
                                  child: Image.network(
                                    element.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, _, __) {
                                      return Image.asset(
                                        imagify('skin'),
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Scan Results: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: mainClr,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ...List.generate(
                                            min(3, element.result.length),
                                            (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${element.result[index]['confidence']} % : ${element.result[index]['label'].toString().substring(element.result[index]['label'].toString().indexOf(' ') + 1)}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Scanned by:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: mainClr,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${element.datetime.year} - ${element.datetime.month} - ${element.datetime.day} ${element.datetime.hour}:${element.datetime.minute}:${element.datetime.second}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        }),
      ),
    );
  }
}
