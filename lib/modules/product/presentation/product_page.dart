import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/modules/product/product_binding.dart';

class ProductPage extends HookConsumerWidget {
  ProductPage(@PathParam('productId') this._productId);

  final String? _productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(_productId ?? "Null");
  }

  void _reloadSearch(WidgetRef ref) {
    ref.read(productControllerProvider(_productId!).notifier).getProduct(
          productId: _productId!,
        );
  }
}
