import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/wish_item_provider.dart';
import 'price_input_formatter.dart';

class ItemEditPage extends ConsumerWidget {
  const ItemEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "edit",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: SelectableText(
                      ref.watch(wishItemProvider).recognizedText.text),
                ),
              ),
            ),
            // 価格入力欄
            Row(
              children: [
                const Text("価格"),
                const Spacer(),
                Flexible(
                  child: TextFormField(
                    initialValue:
                        ref.watch(wishItemProvider).price.priceWithCurrency,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      PriceInputFormatter(),
                    ],
                  ),
                ),
              ],
            ),
            // ブランド入力欄
            Row(
              children: [
                const Text("ブランド"),
                const Spacer(),
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            // カテゴリー入力欄
            Row(
              children: [
                const Text("カテゴリー"),
                const Spacer(),
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    initialValue: ref.watch(wishItemProvider).label,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
