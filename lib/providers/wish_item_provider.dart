import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/price.dart';
import '../domains/wish_item.dart';

final wishItemProvider = StateProvider<WishItem>((ref) => WishItem(
      name: "",
      brand: "",
      price: Price(0),
      label: "",
      recognizedText: "",
    ));
