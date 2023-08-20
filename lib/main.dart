import 'package:flutter/material.dart';

import 'screens/products.dart';

void main() {
  runApp(ProductListApp());
}

class ProductListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List Example',
      home: ProductsScreen(),
    );
  }
}
