import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognize {
  late File inputImageFile;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.japanese);

  TextRecognize(this.inputImageFile);

  Future<RecognizedText> recognize() async {
    final inputImage = InputImage.fromFile(inputImageFile);

    return await textRecognizer.processImage(inputImage);
  }

  closeResources() async {
    await textRecognizer.close();
  }
}
