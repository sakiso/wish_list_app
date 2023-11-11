import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish_list_app/domains/image_labeling.dart';

import '../../domains/text_recognize.dart';
import '../../domains/wish_item.dart';
import '../../providers/wish_item_provider.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          // 画像追加ボタン
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: IconButton(
              onPressed: () async {
                await textRecognizeFromPickedFile(context, ref);
              },
              icon: const Icon(Icons.add_photo_alternate_rounded),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
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

  Future<void> textRecognizeFromPickedFile(context, ref) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    //todo: 読み込み中にローディングを出す
    if (result != null) {
      final targetFile = File(result.files.single.path!);
      // todo: 画像じゃなかったらリターン
      // todo: 複数選択拒否れない？

      Navigator.pushNamed(context, '/item_edit');

      // 画像解析(文字認識・ラベリング)
      final textRecognizer = TextRecognize(targetFile);
      final imageLabeler = ImageLabeling(targetFile);
      // todo: 並列処理にしたい
      final recognizedText = await textRecognizer.recognize();
      final imageLabel = await imageLabeler.firstLabel();

      // todo: ブランドと商品名を取得するためエンティティ分析したい(google_mlkit_entity_extraction)

      // リソース解放
      textRecognizer.closeResources();
      imageLabeler.closeResources();

      // todo: wishItemオブジェクトつくってそれをProviderで共有する
      final wishItem = WishItem(
        recognizedText.text,
        "",
        imageLabel,
        recognizedText,
        0,
      );
      ref.watch(wishItemProvider.notifier).update((state) => wishItem);
    }

    return;
  }
}
