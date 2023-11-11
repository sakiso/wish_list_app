import 'dart:io';

import '../domains/extract_price_from_recognized_text.dart';
import '../domains/image_labeling.dart';
import '../domains/price.dart';
import '../domains/text_recognize.dart';
import '../domains/wish_item.dart';

Future<WishItem> wishItemBuilderFromImageFile(File imageFile) async {
  // 文字解析
  final textRecognizer = TextRecognize(imageFile);
  final recognizedText = await textRecognizer.recognize();

  // 画像ラベリング
  final imageLabeler = ImageLabeling(imageFile);
  final imageLabel = await imageLabeler.firstLabel();

  // 金額抽出
  final priceExtractor = ExtractPriceFromRecognizedText(recognizedText);
  final itemPrice = await priceExtractor.extract();

  // リソース解放
  textRecognizer.closeResources();
  imageLabeler.closeResources();
  priceExtractor.closeResources();

  return WishItem(
    name: "",
    brand: "",
    imageLabel: imageLabel,
    recognizedText: recognizedText,
    price: Price(itemPrice),
  );
}
