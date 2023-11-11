import 'package:flutter/material.dart';

//
// 全面表示のローディング
//
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key, required this.visible});

  //表示状態
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.inverseSurface.withAlpha(140),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
