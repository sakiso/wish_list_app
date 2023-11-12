import 'package:isar/isar.dart';
import 'package:wish_list_app/domains/wish_item.dart';

import '../interfaces/wish_item_repository_interface.dart';
import '../providers/isar_provider.dart';

class WishItemRepository implements IWishItemRepository {
  // todo: interface
  @override
  Future<List<WishItem>> fetchWishItems(ref, {int limit = 10}) async {
    // todo: 作成日順にソートする
    final isar = await _isar(ref);
    return await isar.wishItems
        .where()
        .sortByCreatedAt()
        .limit(limit)
        .findAll();
  }

  @override
  Future<void> saveWishItem(ref, WishItem wishItem) async {
    final isar = await _isar(ref);
    await isar.writeTxn(() async {
      wishItem.createdAt = DateTime.now();
      await isar.wishItems.put(wishItem);
    });
  }

  Future<Isar> _isar(ref) async {
    return await ref.watch(isarProvider);
  }
}
