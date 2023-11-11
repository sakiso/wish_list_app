import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/wish_item_provider.dart';
import '../../services/wish_item_builder_from_image_file.dart';

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

      Navigator.pushNamed(context, '/item_edit');

      final wishItem = await wishItemBuilderFromImageFile(targetFile);

      ref.watch(wishItemProvider.notifier).update((state) => wishItem);
    }

    return;
  }
}
