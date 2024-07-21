import 'package:coffee_shop/components/cart_item.dart';
import 'package:coffee_shop/components/coffee_tile.dart';
import 'package:coffee_shop/components/my_butten.dart';
import 'package:coffee_shop/const.dart';
import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/models/coffee_shop.dart';
import 'package:coffee_shop/pages/payment.dart';
import 'package:coffee_shop/pages/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  void _removeFromCart(Coffee coffee) {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).userCart.remove(coffee);
    });
  }

  void _clearCart() {
    setState(() {
      Provider.of<CoffeeShop>(context, listen: false).userCart.clear();
    });
  }

  double _calculateTotalPrice() {
    return Provider.of<CoffeeShop>(context, listen: false).userCart.fold(
          0.0,
          (total, coffee) => total += (coffee.price * coffee.quantity),
        );
  }

  int _calculateTotalItems() {
    return Provider.of<CoffeeShop>(context, listen: false).userCart.fold(
          0,
          (total, coffee) => total + coffee.quantity,
        );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text('Your Cart'),
        ),
        body: Consumer<CoffeeShop>(builder: (context, coffeeShop, child) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: coffeeShop.userCart.length,
                      itemBuilder: (context, index) {
                        var coffee = coffeeShop.userCart[index];
                        return CartItem(
                          coffee: coffee,
                        );
                      }),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                  'Total Quantity:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text('${_calculateTotalItems().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
              Row(
              children: [
                Text(
                  'Total Price:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                   
                  ],
                ),
                SizedBox(height: 16),
                MyButten(
                  text: 'Pay now',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                        PaymentScreen(onPaymentSuccess: _clearCart)));
                  },
                ),
              ],
            ),
          );
        }));
  }
}
