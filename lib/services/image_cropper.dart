import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageCropper {
  final File imageFile;
  final Rect cropRect;

  ImageCropper({required this.imageFile, required this.cropRect});

  Future<File> copyCrop() async {
    // 画像をロード
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // 切り出し
    int x = cropRect.left.toInt();
    int y = cropRect.top.toInt();
    int width = cropRect.width.toInt();
    int height = cropRect.height.toInt();
    img.Image croppedImage =
        img.copyCrop(image, x: x, y: y, width: width, height: height);

    // 保存用のファイルパスを生成
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath =
        '$appDocPath/cropped_images_test.jpg'; // todo: wishitem.id.jpgにする wishitemモデルにメソッドつくる

    // 画像を保存
    File croppedFile = File(filePath);
    croppedFile.writeAsBytesSync(img.encodeJpg(croppedImage));
    print('--- Cropped image saved at: $filePath ---------');

    return croppedFile;
  }
}
