import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish_list_app/domains/image_labeling.dart';

import '../../domains/text_recognize.dart';
import '../../providers/recognized_text_provider.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: IconButton(
              onPressed: () async {
                await textRecognize(context, ref);
              },
              icon: const Icon(Icons.add_photo_alternate_rounded),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
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

  Future<void> textRecognize(context, ref) async {
    // todo: メソッド分割
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    //todo: 読み込み中にローディングを出す
    if (result != null) {
      final targetFile = File(result.files.single.path!);
      // todo: 画像じゃなかったらリターン

      // Navigator.pushNamed(context, '/item_edit');

      // todo: 並列処理にしたい
      // 画像解析(文字認識・ラベリング)
      final textRecognizer = TextRecognize(targetFile);
      final imageLabeler = ImageLabeling(targetFile);
      final recognizedText = await textRecognizer.recognize();
      final imageLabel = await imageLabeler.firstLabel();

      textRecognizer.closeResources();
      imageLabeler.closeResources();

      ref
          .watch(recognizedTextProvider.notifier)
          .update((state) => "${recognizedText.text}\n\n${imageLabel.label}");
    }
  }
}
