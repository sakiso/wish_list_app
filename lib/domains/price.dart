import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

part 'price.g.dart';

@embedded
class Price {
  final int price;
  // HACK: 引数をrequiredにするとIsarで永続化できないので、しかたなく初期値を設定している
  //       Isar4系からはこの制約はなくなるらしい
  Price([this.price = 0]);

  String get priceWithCurrency {
    // 円固定
    return "¥${formatter.format(price)}";
  }

  static NumberFormat get formatter {
    return NumberFormat("#,###");
  }

  static Price fromString(String priceString) {
    priceString = priceString.replaceAll("¥", "");
    priceString = priceString.replaceAll(",", "");

    if (int.tryParse(priceString) == null) {
      throw ArgumentError("$priceString を数値に変換できませんでした");
    }

    return Price(int.parse(priceString));
  }
}
