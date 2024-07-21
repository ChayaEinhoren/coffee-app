import 'package:flutter/material.dart';
import 'package:coffee_shop/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  final void Function()? onPressed;
 
  const CoffeeTile({required this.coffee, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        leading: Image.asset(coffee.imagePath),
        title: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            coffee.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text('\$${coffee.price}'),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.brown[300]),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
