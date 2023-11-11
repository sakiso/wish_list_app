import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// todo: Isarで永続化する

class WishItem {
  final String name;
  final String brand;
  final ImageLabel label;
  final RecognizedText recognizedText;
  final int price;

  WishItem(
    this.name,
    this.brand,
    this.label,
    this.recognizedText,
    this.price,
  );

  priceWithCurrency() {
    // 円固定
    return "¥$price";
  }
}
