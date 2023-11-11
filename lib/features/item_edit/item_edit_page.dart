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
            Text(ref.watch(wishItemProvider).recognizedText.text),
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
                    ], // 追加
                  ),
                ),
              ],
            ),
            Text(ref.watch(wishItemProvider).label),
          ],
        ),
      ),
    );
  }
}
