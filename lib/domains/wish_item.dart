import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// todo: Isarで永続化する

class WishItem {
  final String name;
  final String brand;
  final ImageLabel imageLabel;
  final RecognizedText recognizedText;
  int price = 0;

// todo: 画像

  WishItem({
    required this.name,
    required this.brand,
    required this.imageLabel,
    required this.recognizedText,
    required this.price,
  });

  String get priceWithCurrency {
    // 円固定
    return "¥$price";
  }

  String get label {
    // 円固定
    return imageLabel.label;
  }

  // todo: recognizeとかと合わせてビルダーにする
  // todo: recognizedTextに対するエンティティ
}
