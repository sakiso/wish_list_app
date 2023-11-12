import 'dart:io';

import 'package:wish_list_app/services/image_cropper.dart';

import '../domains/extract_price_from_recognized_text.dart';
import '../domains/image_labeling.dart';
import '../domains/object_detection.dart';
import '../domains/price.dart';
import '../domains/text_recognize.dart';
import '../domains/wish_item.dart';

Future<WishItem> wishItemBuilderFromImageFile(File imageFile) async {
  // todo: 一連の画像処理は別クラスに切り出す あと画像処理はdomainからserviceに移動する

  // 文字解析
  final textRecognizer = TextRecognize(imageFile);
  final recognizedText = await textRecognizer.recognize();

  // オブジェクト検出
  final objectDetector = ObjectDetection(imageFile);
  final object = await objectDetector.detect();

  // 画像の代表オブジェクト部分切り出し(該当なしの場合あり)
  File? croppedImageFile;
  if (object != null) {
    final ImageCropper imageCropper =
        ImageCropper(cropRect: object.boundingBox, imageFile: imageFile);
    croppedImageFile = await imageCropper.copyCrop();
  }

  // 画像ラベリング(代表オブジェクトがある場合はその部分の画像だけ使う)
  final imageLabeler = ImageLabeling(croppedImageFile ?? imageFile);
  final imageLabel = await imageLabeler.firstLabel();

  // 金額抽出
  final priceExtractor = ExtractPriceFromRecognizedText(recognizedText);
  final itemPrice = await priceExtractor.extract();

  // リソース解放
  textRecognizer.closeResources();
  imageLabeler.closeResources();
  priceExtractor.closeResources();
  objectDetector.closeResources();

  return WishItem(
    name: "",
    brand: "",
    imageLabel: imageLabel,
    recognizedText: recognizedText,
    price: Price(itemPrice),
  );
}
