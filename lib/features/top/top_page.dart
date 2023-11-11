import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../domains/recognized_text_provider.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          IconButton(
            onPressed: () async {
              await textRecognize(ref);
            },
            icon: const Icon(Icons.add_photo_alternate_rounded),
          ),
          Text(ref.watch(recognizedTextProvider)),
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

  Future<void> textRecognize(ref) async {
    // todo: 画像解析したら別ページで表示させるようにする
    // todo: メソッド分割
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    //todo: 読み込み中にローディングを出す
    if (result != null) {
      final inputImage = InputImage.fromFile(File(result.files.single.path!));
      // todo: 画像じゃなかったらリターン

      // 文字認識
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.japanese);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      // ラベリング
      final ImageLabelerOptions options =
          ImageLabelerOptions(confidenceThreshold: 0.5);
      final imageLabeler = ImageLabeler(options: options);
      final List<ImageLabel> labels =
          await imageLabeler.processImage(inputImage);
      final firstLabelText = labels[0].label;

      ref
          .watch(recognizedTextProvider.notifier)
          .update((state) => "${recognizedText.text}\n\n$firstLabelText");

      // リソースの開放
      textRecognizer.close();
      imageLabeler.close();
    }
  }
}
