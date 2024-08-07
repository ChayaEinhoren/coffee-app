import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/models/coffee.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

// class MailService extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// }

//   Stream<List<Users>> getUsersStream() {
//     return _firestore.collection("Users").snapshots().map((snapshot){
//         return snapshot.docs.map((doc) =>
//         Users.fromMap(doc.data() as Map<String, dynamic>)).toList();
//     });
//   }

//   class MailService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addUserEmail(String email) async {
//     try {
//       await _firestore.collection('Users').add({
//         'email': email,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error adding user email: $e');
//     }
// //   }
// // }

// class MailService {
//   final smtpServer = gmail("michal84446@gmail.com", "rshs hwmj obfo ystv");
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addUser(Users user) async {
//     try {
//       await _firestore.collection('Users').doc(user.uid).set(user.toMap());
//     } catch (e) {
//       print('Error adding user: $e');
//     }
//   }

//  Future<void> sendVerificationCode(String email, String code) async {
//     final message = Message()
//       ..from = Address('michal84446@gmail.com', 'CoffeeApp')
//       ..recipients.add(email)
//       ..subject = 'Verification Code'
//       ..text = 'Your verification code is: $code';

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } catch (e) {
//       print('Error sending email: $e');
//     }
//   }
// }

// int generateSixDigitNumber() {
//   Random random = Random();
//   int min = 100000;
//   int max = 999999;
//   return min + random.nextInt(max - min + 1);
// }

// void _sendVerificationCode() async {
//   if (isSelected[1]) {
//     String email = emailController.text;
//     String userId = _generateUserId();
//     Users user = Users(uid: userId, email: email);

//     // Create the verification code
//     int verificationCode = generateSixDigitNumber();

//     // Save user to Firestore
//     await mailService.addUser(user);

//     // Send the verification email
//     await mailService.sendVerificationEmail(email, verificationCode.toString());
//   }
// }/// יש לי את הפונקציה ב לוגין

final smtpServer = gmail("chl5712483@gmail.com", "vfiv dhkt xbzx sdyr");

String generateVerificationCode() {
  final random = Random();
  return List.generate(6, (index) => random.nextInt(10).toString()).join();
}

Future<void> sendEmail(
    String recipientEmail, String subject, String body) async {
  final message = Message()
    ..from = Address("chl5712483@gmail.com", 'CoffeeApp')
    ..recipients.add(recipientEmail)
    ..subject = subject
    ..text = body;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n${e.toString()}');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

Future<String> sendVerificationEmail(String email, String uid) async {
  String code = generateVerificationCode();
  String subject = "Your Verification Code";
  String body = "Your verification code is: $code";

  await sendEmail(email, subject, body);
  await saveUserIfNotExists(email, uid);
  return code;
}

Future<bool> checkIfEmailExists(String email) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

Future<void> saveUserIfNotExists(String email, String uid) async {
  bool emailExists = await checkIfEmailExists(email);

  if (!emailExists) {
    Users user = Users(uid: uid, email: email);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(user.toMap());
    print('User saved successfully');
  } else {
    print('Email already exists in the database');
  }
}

Future<void> sendOrderDetails(String email,Coffee coffee) async {
  String subject = "Your Order Details";
  StringBuffer body = StringBuffer();
  body.writeln("Thank you for your order!");
  body.writeln("\nOrder Details:\n");

  for (var item in userCart) {
    body.writeln("Product: ${item['productName']}");
    body.writeln("Quantity: ${item['quantity']}");
    body.writeln("Price: ${item['price']}");
    body.writeln("\n");
  }
  body.writeln("Thank you for shopping with us!");
  await sendEmail(email, subject, body.toString());

}
