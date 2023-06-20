import 'package:flutter/material.dart';
import 'package:mspr/modules/product/data/models/product.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({super.key, required this.data});

  final Product data;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Image.asset("assets/graphic/cafe1.png"),
            title: Text(data.label),
            subtitle: Text(
              data.ref,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              data.description,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              data.date_creation,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "${data.price.toString()} €",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              data.stock_reel.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Perform some action
                },
                child: const Text('En savoir plus'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
