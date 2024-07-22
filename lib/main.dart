import 'package:coffee_shop/firebase_options.dart';
import 'package:coffee_shop/models/coffee_shop.dart';
import 'package:coffee_shop/pages/intro_screen.dart';
import 'package:coffee_shop/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: DefaualtFirebaseOptions.currentPlatform);
      
//   runApp(MyApp());
// }
// void main() async {
// WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaualtFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {

    

    return ChangeNotifierProvider(
      create: (context)=> CoffeeShop(),
      builder:(context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
