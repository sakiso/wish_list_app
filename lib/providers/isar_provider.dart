import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wish_list_app/domains/wish_item.dart';

final Provider<Future<Isar>> isarProvider = Provider(
  (ref) async {
    return await getOrInitializeIsar();
  },
);

Future<Isar> getOrInitializeIsar() async {
  const isarName = "isar_wish_list";
  // Isarのインスタンスをシングルトンで返す
  final singletonIsar = Isar.getInstance(isarName);
  final existIsarInstance = singletonIsar != null;
  if (existIsarInstance) return singletonIsar;

  // インスタンスがない場合は初期化して返す
  final directory = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [WishItemSchema],
    name: isarName,
    directory: directory.path,
  );
  return isar;
}
