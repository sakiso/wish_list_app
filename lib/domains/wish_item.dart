import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';

// todo: Isarで永続化する

class WishItem {
  final String name;
  final String brand;
  final ImageLabel imageLabel;
  final RecognizedText recognizedText;
  final int price;

// todo: 画像も表示できるようにする

  WishItem({
    required this.name,
    required this.brand,
    required this.imageLabel,
    required this.recognizedText,
    required this.price,
  });

  String get priceWithCurrency {
    // 円固定
    final formatter = NumberFormat("#,###");
    return "¥${formatter.format(price)}";
  }

  String get label {
    // 円固定
    return imageLabel.label;
  }

  // todo: ImageLabelを翻訳して保存したほうがいいかも
}
