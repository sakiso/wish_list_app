import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ExtractPriceFromRecognizedText {
  final RecognizedText recognizedText;
  final entityExtractor =
      EntityExtractor(language: EntityExtractorLanguage.japanese);

  ExtractPriceFromRecognizedText(this.recognizedText);

  Future<int> extract() async {
    int price = 0;

    final List<EntityAnnotation> annotations =
        await entityExtractor.annotateText(recognizedText.text);

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
