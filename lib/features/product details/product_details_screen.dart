import 'package:carecomm/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(product.image!),
              SizedBox(height: 16),
              Text(
                product.title!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('\$${product.price}'),
              SizedBox(height: 16),
              Text(product.description!),
              SizedBox(height: 16),
              Text('Category: ${product.category}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text('Rate: ${product.rating!.rate}'),
                  SizedBox(width: 10),
                  Text('Count: ${product.rating!.count}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
