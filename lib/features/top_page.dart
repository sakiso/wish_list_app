import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../domains/recognized_text_provider.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextButton(
            onPressed: () async {
              await textRecognize(ref);
            },
            child: const Text('ボタン'),
          ),
          Text(ref.watch(recognizedTextProvider).text),
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
    // todo: メソッド分割
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    //todo: 読み込み中にローディングを出す
    if (result != null) {
      final inputImage = InputImage.fromFile(File(result.files.single.path!));
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.japanese);

      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      ref
          .watch(recognizedTextProvider.notifier)
          .update((state) => recognizedText);
    }
  }
}
