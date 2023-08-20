import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/api_services/api.dart';
import 'package:flutter_ecommerce/model/product_model.dart';

import 'product_details.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> products = [];
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load() async {
    loading = true;
    products = await ApiServices().getProducts();
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("E-commerce"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(child: Text("Products not found"))
              : productListUi(products: products),
    );
  }
}

class productListUi extends StatelessWidget {
  const productListUi({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final ProductModel data = products[index];
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(),
                ));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.thumbnail),
          ),
          title: Text(data.title),
          subtitle: Text(
            data.description,
            maxLines: 2,
          ),
          trailing: Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
