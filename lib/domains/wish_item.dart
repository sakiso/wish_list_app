import 'package:wish_list_app/domains/price.dart';
import 'package:isar/isar.dart';

part 'wish_item.g.dart';
// todo: Isarで永続化する

@collection
class WishItem {
  Id id;
  final String name;
  final String brand;
  final String label;
  final String recognizedText;
  final Price price;

// todo: 画像も表示できるようにする

  WishItem({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.brand,
    required this.label,
    required this.recognizedText,
    required this.price,
  });
}
