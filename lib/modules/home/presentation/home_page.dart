import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/modules/home/list_product_binding.dart';
import 'package:mspr/modules/home/widgets/product_card.dart';
import 'package:mspr/modules/home/widgets/product_card_view.dart';

import '../../../core/widgets/alert_widget.dart';
import '../../../core/widgets/loading_indicator_widget.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Paye ton kawa',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
          ),
          actions: <Widget>[
            // action button
            IconButton(
              icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
              onPressed: () {},
            ),
          ]),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: ref.watch(listProductControllerProvider).when(
                data: (value) => Column(
                  children: <Widget>[
                    Row(children: const <Widget>[
                      Text('Historique de commandes',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 14),
                          textAlign: TextAlign.left)
                    ]),
                    const SizedBox(
                      height: 18,
                    ),
                    ProductCardView(),
                    ProductCard(
                      data: value![0],
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisSpacing: 20,
                    //     mainAxisSpacing: 20,
                    //     crossAxisCount: 2,
                    //   ),
                    //   itemCount: value?.length,
                    //   itemBuilder: (context, index) {
                    //     final product = value![index];
                    //     return ProductCard(
                    //       data: product,
                    //     );
                    //   },
                    // )
                  ],
                ),
                error: (error, _) =>
                    AlertWidget(message: error.toString(), isError: true),
                loading: () => const Center(
                  child: LoadingIndicatorWidget(),
                ),
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _reloadSearch(ref);
        },
        tooltip: 'Add Task',
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  void _reloadSearch(WidgetRef ref) {}
}
