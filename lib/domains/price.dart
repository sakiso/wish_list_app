import 'package:intl/intl.dart';

class Price {
  final int price;
  Price(this.price);

  String get priceWithCurrency {
    // 円固定
    return "¥${formatter.format(price)}";
  }

  static NumberFormat get formatter {
    return NumberFormat("#,###");
  }
}
