import 'package:coffee_shop/components/my_butten.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _imagePathController = TextEditingController();

  final List<Map<String, String>> _products = [];

    Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final newProduct = {
        'name': _productNameController.text,
        'price': _productPriceController.text,
        'image': _imagePathController.text,
      };

      // Add the product to the Firestore collection
      await FirebaseFirestore.instance.collection('products').add(newProduct);

      setState(() {
        _products.add(newProduct);
      });
      _productNameController.clear();
      _productPriceController.clear();
      _imagePathController.clear();
    }
  }

  void _removeProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: _productNameController,
                      decoration: InputDecoration(labelText: 'Product Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _productPriceController,
                      decoration: InputDecoration(labelText: 'Product price'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product price';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _imagePathController,
                      decoration: InputDecoration(labelText: 'Image path'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an image path';
                        }
                        return null;
                      }),
                  SizedBox(height: 16),
                  MyButten(onTap: _addProduct, text: 'Add Product'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return ListTile(
                        leading: Image.asset(product['image']!),
                        title: Text(product['name']!),
                        subtitle: Text('\$${product['price']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeProduct(index),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
