import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

final recognizedTextProvider = StateProvider<RecognizedText>(
    (ref) => RecognizedText(text: "", blocks: []));
