import 'package:firebase_core/firebase_core.dart';

class DefaualtFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyA--003nKzEQ57u8q5YIaxnrt0uzQjOwpE",
    appId: "1:22056606059:android:61fc2fe2c7f262706dd42e",
    projectId: 'coffee-shop-1f633',
    messagingSenderId:'22056606059',
    storageBucket: 'coffee-shop-1f633.appspot.com'
  );
}
