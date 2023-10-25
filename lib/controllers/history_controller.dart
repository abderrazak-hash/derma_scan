import 'package:derm_ai_scan/models/history_element.dart';
import 'package:derm_ai_scan/services/dataset_service.dart';
import 'package:flutter/material.dart';

class HistoryController extends ChangeNotifier {
  List<HistoryElement> history = [];

  Future<List<HistoryElement>> loadHistory() async {
    return await DatasetService.getHistory();
  }
}
