import 'dart:io';

import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectDetection {
  late File inputImageFile;
  final options = ObjectDetectorOptions(
    mode: DetectionMode.single, // or stream,
    classifyObjects: true, // オブジェクトの分類を実施する
    multipleObjects: false, // 最も目立つオブジェクト一つを検出する
  );
  late ObjectDetector objectDetector;

  ObjectDetection(this.inputImageFile) {
    objectDetector = ObjectDetector(options: options);
  }

  Future<DetectedObject?> detect() async {
    final inputImage = InputImage.fromFile(inputImageFile);
    final List<DetectedObject> objects =
        await objectDetector.processImage(inputImage);

    // デバッグ用log
    for (DetectedObject detectedObject in objects) {
      print("---- object detected -------------------");
      for (Label label in detectedObject.labels) {
        print('${label.text} ${label.confidence}');
      }
    }

    // NOTE: 何もオブジェクトが検出できないことがある
    return objects.isNotEmpty ? objects[0] : null;
  }

  closeResources() async {
    await objectDetector.close();
  }
}
