import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ExtractPriceFromRecognizedText {
  final RecognizedText recognizedText;
  final entityExtractor =
      EntityExtractor(language: EntityExtractorLanguage.japanese);

  ExtractPriceFromRecognizedText(this.recognizedText);

  Future<int> extract() async {
    int price = 0;

    // NOTE: 日本語設定にしているはずだが"円"だと金額と認識されないので"¥"に置換してから分析する
    final preprocessedText = recognizedText.text.replaceAll('円', '¥');
    final List<EntityAnnotation> annotations =
        await entityExtractor.annotateText(preprocessedText);

    print("---- recognizedText text-------------------");
    print(recognizedText.text);

    for (final annotation in annotations) {
      for (final entity in annotation.entities) {
        print("---- annotation entity-------------------");
        print(annotation.text);
        print(entity.rawValue);
        print(entity.type);
        print("-----------------------");
      }
    }

    for (final annotation in annotations) {
      if (annotation.entities
          .any((entity) => entity.type == EntityType.money)) {
        // カンマや¥などを除去し数値のみ抽出する
        final priceString = annotation.text.replaceAll(RegExp(r'[^\d]'), '');
        price = int.parse(priceString);
        break;
      }
    }
    return price;
  }

  closeResources() async {
    await entityExtractor.close();
  }
}
