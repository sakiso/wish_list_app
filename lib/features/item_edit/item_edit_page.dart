import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domains/price.dart';
import '../../domains/wish_item.dart';
import '../../interfaces/wish_item_repository_interface.dart';
import '../../providers/wish_item_provider.dart';
import '../../repositories/wish_item_repository.dart';
import 'price_input_formatter.dart';

final formKey = GlobalKey<FormState>();

class ItemEditPage extends ConsumerWidget {
  final nameFieldKey = GlobalKey<FormFieldState>();
  final priceFieldKey = GlobalKey<FormFieldState>();
  final brandFieldKey = GlobalKey<FormFieldState>();
  final categoryFieldKey = GlobalKey<FormFieldState>();

  ItemEditPage({Key? key}) : super(key: key);

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
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: SelectableText(
                      ref.watch(wishItemProvider).recognizedText),
                ),
              ),
            ),
            // 品名入力欄
            Row(
              children: [
                const Text("品名"),
                const Spacer(),
                Flexible(
                  child: TextFormField(
                    key: nameFieldKey,
                  ),
                ),
              ],
            ),
            // 価格入力欄
            Row(
              children: [
                const Text("価格"),
                const Spacer(),
                Flexible(
                  child: TextFormField(
                    key: priceFieldKey,
                    initialValue:
                        ref.watch(wishItemProvider).price.withCurrency,
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
                    key: brandFieldKey,
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
                    key: categoryFieldKey,
                    textAlign: TextAlign.end,
                    initialValue: ref.watch(wishItemProvider).label,
                  ),
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  _saveWishItem(ref);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onPrimary),
                ),
                child: const Text("保存")),
          ],
        ),
      ),
    );
  }

  Future<void> _saveWishItem(ref) async {
    // todo: validation(Form & model両方で?)
    print("--- formKey.currentState -------------");
    final name = nameFieldKey.currentState!.value;
    final price = Price.fromString(priceFieldKey.currentState!.value);
    final String brand = brandFieldKey.currentState!.value;
    final String category = categoryFieldKey.currentState!.value;
    final String recognizedText = ref.watch(wishItemProvider).recognizedText;

    IWishItemRepository wishItemRepository = WishItemRepository();

    final wishItem = WishItem(
      name: name,
      price: price,
      brand: brand,
      label: category,
      recognizedText: recognizedText,
    );

    // wishItemProviderのstateは破棄しといて、新しいWishItemつくって、リポジトリで保存する
    wishItemRepository.saveWishItem(ref, wishItem);
  }
}
