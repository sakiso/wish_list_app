import 'package:wish_list_app/domains/wish_item.dart';

abstract class IWishItemRepository {
  Future<List<WishItem>> fetchWishItems(ref, {int limit = 10});
  Future<void> saveWishItem(ref, WishItem wishItem);
}
