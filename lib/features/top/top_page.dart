import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/wish_list.dart';
import '../../providers/wish_item_provider.dart';
import '../../providers/loading_overlay_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../repositories/wish_item_repository.dart';
import '../../services/wish_item_builder_from_image_file.dart';
import '../loading_overlay/loading_overlay.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends ConsumerState<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              children: [
                // 最近追加されたアイテム
                _recentlyAddedItems(context, ref),
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
            ),
          ),
          LoadingOverlay(
            visible: ref.watch(loadingOverlayProvider),
          ),
        ],
      ),
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

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final repository = WishItemRepository();
    final recentlyAddedItems = await repository.fetchWishItems(ref, limit: 3);
    final wishList = WishList(wishItems: recentlyAddedItems);

    ref.read(wishListProvider.notifier).loadWishList(wishList);
  }

  Future<void> textRecognizeFromPickedFile(context, ref) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      _turnOffLoadingOverlay(ref);
      return;
    }
    if (_isNotImage(result.files.single.path!)) {
      _turnOffLoadingOverlay(ref);
      return;
    }

    // ローディング画面表示
    ref.read(loadingOverlayProvider.notifier).update((state) => true);

    final targetFile = File(result.files.single.path!);
    final wishItem = await wishItemBuilderFromImageFile(targetFile);
    await ref.watch(wishItemProvider.notifier).update((state) => wishItem);

    Navigator.pushNamed(context, '/item_edit');

    _turnOffLoadingOverlay(ref);
    return;
  }

  bool _isNotImage(String filePath) {
    final lowerCaseFilePath = filePath.toLowerCase();

    if (lowerCaseFilePath.endsWith('.jpg') ||
        lowerCaseFilePath.endsWith('.jpeg') ||
        lowerCaseFilePath.endsWith('.png') ||
        lowerCaseFilePath.endsWith('.bmp')) {
      return false;
    }
    // どの拡張子にも一致しない場合は画像ではないと判断
    return true;
  }

  void _turnOffLoadingOverlay(ref) {
    ref.read(loadingOverlayProvider.notifier).update((state) => false);
  }

  Widget _recentlyAddedItems(BuildContext context, WidgetRef ref) {
    final wishItems = ref.watch(wishListProvider);

    // todo:ロード完了までブランクのオブジェクトが入ったListが表示される。Null許容にする

    if (wishItems.isEmpty) {
      return const Text("最近追加されたアイテムはありません");
    }
    return SizedBox(
      height: 190,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: wishItems
                .map(
                  (wishItem) => ListTile(
                    title: Text(wishItem.name),
                    subtitle: Text(wishItem.price.withCurrency),
                    // todo: Cardつかっていい感じのデザインにする
                    //       https://api.flutter.dev/flutter/material/ListTile-class.html
                    // todo: image実装したらコメントアウト外す
                    // leading: Image.file(
                    //   File(wishItem.imagePath),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
