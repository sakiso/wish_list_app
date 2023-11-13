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

    print("-- image label -----------");
    print(imageLabel[0].label);
    print(imageLabel[1].label);
    print("--------------------------");

    return imageLabel[0];
    // todo: 結構ScreenshotとかPosterになるので、オブジェクトトラッキングで画像を切り取りラベリングする
  }

  closeResources() async {
    await imageLabeler.close();
  }

  labeling() {}
}
