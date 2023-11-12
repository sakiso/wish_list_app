import 'package:wish_list_app/domains/wish_item.dart';

abstract class IWishItemRepository {
  Future<List<WishItem>> fetchWishItems(ref);
  Future<void> saveWishItem(ref, WishItem wishItem);
}
