import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Coffee coffee;

  

  CartItem({required this.coffee});

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(coffee.imagePath, height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.name, style: TextStyle(fontSize: 18)),
                Text('Quantity:${coffee.quantity}'),
                Text('Total: \$${(coffee.price * coffee.quantity).toStringAsFixed(2)}')
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.brown),
              onPressed: () {
                Provider.of<CoffeeShop>(context, listen: false)
                    .removeFromCart(coffee);
                
              },
            )
          ],
        ),
      ),
    );
  }
}
