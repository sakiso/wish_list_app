import 'dart:collection';

import 'package:wish_list_app/domains/wish_item.dart';

class WishList with IterableMixin<WishItem> {
  final List<WishItem> wishItems;

  WishList({required this.wishItems});

  @override
  Iterator<WishItem> get iterator => wishItems.iterator;

  static WishList buildBlankWishList() {
    return WishList(wishItems: [WishItem.buildBlankWishItem()]);
  }
}
