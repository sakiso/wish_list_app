import 'dart:io';

import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ImageLabeling {
  File inputImageFile;
  final imageLabeler =
      ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));

  ImageLabeling(this.inputImageFile);

  Future<ImageLabel> firstLabel() async {
    final inputImage = InputImage.fromFile(inputImageFile);
    final imageLabel = await imageLabeler.processImage(inputImage);

    return imageLabel[0];
  }

  closeResources() async {
    await imageLabeler.close();
  }

  labeling() {}
}
