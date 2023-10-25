// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derm_ai_scan/models/history_element.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:derm_ai_scan/services/auth_service.dart';

class DatasetService {
  static String collection = 'ScanResults';
  static Future<Map<String, String>> uploadImageToDataset(
      String imagePath) async {
    Reference reference = FirebaseStorage.instance.ref();
    Reference usersReference = reference.child('skin_images');
    String uniqueName = DateTime.now().toString();
    uniqueName = uniqueName.substring(0, uniqueName.indexOf('.'));
    Reference userImageReference = usersReference.child(uniqueName);
    await userImageReference.putFile(File(imagePath));
    String url = await userImageReference.getDownloadURL();
    return {uniqueName: url};
  }

  static Future<void> createScanResult(
      Map<String, String> imageData, List<Map<String, dynamic>> result) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(AuthService.currentUser!.uid)
          .update({
        imageData.keys.toList()[0]: imageData.values.toList()[0]
      }).then((value) async {
        for (int i = 0; i < result.length; i++) {
          await FirebaseFirestore.instance
              .collection(collection)
              .doc(AuthService.currentUser!.uid)
              .collection(imageData.keys.toList()[0])
              .doc(i.toString())
              .set(result[i]);
        }
      });
    } catch (e) {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(AuthService.currentUser!.uid)
          .set({imageData.keys.toList()[0]: imageData.values.toList()[0]}).then(
              (value) async {
        for (int i = 0; i < result.length; i++) {
          await FirebaseFirestore.instance
              .collection(collection)
              .doc(AuthService.currentUser!.uid)
              .collection(imageData.keys.toList()[0])
              .doc(i.toString())
              .set(result[i]);
        }
      });
    }
  }

  static Future<void> saveResult(
      String imagePath, List<Map<String, dynamic>> result) async {
    Map<String, String> imageData = await uploadImageToDataset(imagePath);
    createScanResult(imageData, result);
  }

  static Future<List<HistoryElement>> getHistory() async {
    List<HistoryElement> history = [];
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(AuthService.currentUser!.uid)
        .get()
        .then((value) async {
      List res = [];
      Map urls = {};
      for (int i = 0; i < value.data()!.keys.toList().length; i++) {
        res.add(value.data()!.keys.toList()[i].toString());
        urls.addAll({res.last: value.data()!.values.toList()[i].toString()});
      }
      for (String image in res) {
        history.add(HistoryElement(imageUrl: urls[image], result: [], datetime: DateTime.parse(image)));
        int i = 0;
        while (i < 3) {
          try {
            await FirebaseFirestore.instance
                .collection(collection)
                .doc(AuthService.currentUser!.uid)
                .collection(image)
                .doc('$i')
                .get()
                .then((v) {
              history.last.result.add(v.data()!);
              i++;
            });
          } catch (e) {
            i++;
            break;
          }
        }
      }
    });
    return history;
  }
}
