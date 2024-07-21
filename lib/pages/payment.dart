import 'package:coffee_shop/components/my_butten.dart';
import 'package:coffee_shop/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  final VoidCallback onPaymentSuccess;

  PaymentScreen({required this.onPaymentSuccess});

  _paymentPageState createState() => _paymentPageState();
}

class _paymentPageState extends State<PaymentScreen> {
  String CardNumber = '';
  String expirydate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: CardNumber,
              expiryDate: expirydate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: CardNumber,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expirydate,
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    SizedBox(height: 20),
                    MyButten(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          widget.onPaymentSuccess();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Payment Successful!!"),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          print("invalid");
                        }
                      },
                      // child: Container(
                      //   margin: EdgeInsets.all(8),
                      //   child: Text('validate',
                      //       style:
                      //           TextStyle(color: Colors.white, fontSize: 18),
                      //     ),
                      // ),
                      text: 'Pay now',

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      CardNumber = creditCardModel.cardNumber;
      expirydate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

}