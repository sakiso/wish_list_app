import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
          child: Text('ここでボタン押して画像読み込んでTextRecognizerで文字認識して、その結果を表示する')),
      appBar: AppBar(
        title: Text(
          "top",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
