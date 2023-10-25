import 'package:derm_ai_scan/constants.dart';
import 'package:derm_ai_scan/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadBottomSheet extends StatelessWidget {
  const UploadBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageController>(
      builder: (_, imageController, child) {
        return BottomSheet(
          onClosing: () {},
          backgroundColor: white,
          builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 30.0),
                      const Text(
                        'Pick an image from:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 21,
                          color: black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await imageController.pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              iconify('gallery'),
                              height: 45,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Gallery',
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      InkWell(
                        onTap: () async {
                          await imageController.pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              iconify('camera'),
                              // width: 45,
                              height: 45,
                              fit: BoxFit.fitHeight,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Camera',
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
