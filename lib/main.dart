import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/top_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wish list app',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "NotoSansJP",
        colorSchemeSeed: const Color.fromARGB(255, 35, 72, 132),
        // ColorPalette => https://colorscheme.enoiu.com/
      ),
      routes: {
        '/': (context) => const TopPage(),
      },
    );
  }
}
