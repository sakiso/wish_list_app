import 'package:wish_list_app/domains/price.dart';
import 'package:isar/isar.dart';

part 'wish_item.g.dart';
// todo: Isarで永続化する

@collection
class WishItem {
  Id? id;
  final String name;
  final String brand;
  final String label; // todo: 画面上「カテゴリー」と言っているところがあるので統一する
  final String recognizedText;
  final Price price;
  DateTime? createdAt;

// todo: 画像も表示できるようにする

  WishItem({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.brand,
    required this.label,
    required this.recognizedText,
    required this.price,
  });

  static WishItem buildBlankWishItem() {
    return WishItem(
      id: null,
      name: "",
      brand: "",
      label: "",
      recognizedText: "",
      price: Price(0),
    );
  }

  WishItem copyWith({
    String? inputName,
    String? inputBrand,
    String? inputLabel,
    String? inputRecognizedText,
    Price? inputPrice,
  }) {
    return WishItem(
      id: Isar.autoIncrement,
      name: inputName ?? name,
      brand: inputBrand ?? brand,
      label: inputLabel ?? label,
      recognizedText: inputRecognizedText ?? recognizedText,
      price: inputPrice ?? price,
    );
  }
}
