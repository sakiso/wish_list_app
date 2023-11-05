import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text('文字解析の結果を表示したい'),
          TextButton(
            onPressed: () async {
              await textRecognize();
            },
            child: const Text('ボタン'),
          )
        ],
      )),
      appBar: AppBar(
        title: Text(
          "top",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  Future<void> textRecognize() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result.files.single.path!);
      print("result.files.single.path!");

      final inputImage = InputImage.fromFile(File(result.files.single.path!));

      print("inputImage");
      print(inputImage);
      final textRecognizer = TextRecognizer();

      print("-----------------");

      // todo: TextRecognizerのスクリプトに日本語を設定していると、ここでクラッシュする
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      print("@@@@@@@@@@@@@@@@");

      print("recognize");
    } else {}

    // String text = recognizedText.text;
    // for (TextBlock block in recognizedText.blocks) {
    //   final Rect rect = block.boundingBox;
    //   final List<Point<int>> cornerPoints = block.cornerPoints;
    //   final String text = block.text;
    //   final List<String> languages = block.recognizedLanguages;

    //   for (TextLine line in block.lines) {
    //     // Same getters as TextBlock
    //     for (TextElement element in line.elements) {
    //       // Same getters as TextBlock
    //     }
    //   }
    // }
  }
}
