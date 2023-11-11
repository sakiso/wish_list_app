import 'package:flutter_riverpod/flutter_riverpod.dart';

// todo: 適切な集約クラスにする
final recognizedTextProvider = StateProvider<String>((ref) => "");
