import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../domains/wish_item.dart';

final wishItemProvider = StateProvider<WishItem>((ref) => WishItem(
    "",
    "",
    ImageLabel(confidence: 0, label: "", index: 0),
    RecognizedText(text: "", blocks: []),
    0));
