import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/wish_list.dart';

class WishListNotifier extends StateNotifier<WishList> {
  WishListNotifier() : super(WishList.buildBlankWishList());

  void loadWishList(WishList wishList) {
    state = wishList;
  }
}

final wishListProvider =
    StateNotifierProvider<WishListNotifier, WishList>((ref) {
  return WishListNotifier();
});
