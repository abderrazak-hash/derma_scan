import 'package:derm_ai_scan/services/dataset_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class DiseaseController extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> classifyDisease(String imagePath) async {
    await loadModel();
    List<dynamic>? output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 198,
      imageMean: 117.0,
      imageStd: 1.0,
      threshold: 0.1,
    );
    await Future.delayed(const Duration(seconds: 2));
    List<Map<String, dynamic>> data = [];
    for (var item in output!) {
      data.add({
        'label':
            '${item['index'].toString().padRight(3, ' ')} ${item['label'].toString().replaceAll('"', '')}',
        'confidence': (double.parse(item['confidence'].toString()) * 10000)
                .roundToDouble() /
            100,
      });
    }
    Tflite.close();
    return data;
  }

  Future<void> saveResult(
      String imagePath, List<Map<String, dynamic>> result) async {
    await DatasetService.saveResult(imagePath, result);
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/skin_model.tflite",
      labels: "assets/models/skin_labels.txt",
    );
  }
}
