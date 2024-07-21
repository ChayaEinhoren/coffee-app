// import 'dart:math';

// import 'package:coffee_shop/components/my_butten.dart';
// import 'package:coffee_shop/const.dart';
// import 'package:coffee_shop/models/coffee.dart';
// import 'package:coffee_shop/servises/mail_servise.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   List<bool> isSelected = [true, false];
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController codeController = TextEditingController();
//   final MailService mailService = MailService();
//   bool isCodeSent = false;
//   String? verificationCode;
//   String? errorMessage;

//   void initState() {
//     super.initState();
//     phoneController.text = '+972';
//   }

//   void dispose() {
//     phoneController.dispose();
//     emailController.dispose();
//     codeController.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: backgroundColor,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(25),
//                 child: Image.asset('lib/images/espresso.png', height: 200),
//               ),
//               SizedBox(height: 48),
//               Text(
//                 "ברוכים הבאים",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.brown[800],
//                     fontSize: 24),
//               ),
//               SizedBox(
//                 height: 24,
//               ),
//               Text(
//                 "הזינו את מספר הטלפון או המייל על מנת להיכנס",
//                 style: TextStyle(color: Colors.grey[700], fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               ToggleButtons(
//                 borderRadius: BorderRadius.circular(10),
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text("טלפון"),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text('מייל'),
//                   ),
//                 ],
//                 isSelected: isSelected,
//                 onPressed: (int index) {
//                   setState(() {
//                     for (int i = 0; i < isSelected.length; i++) {
//                       isSelected[i] = i == index;
//                     }
//                     if (isSelected[0]) {
//                       phoneController.text = '+972';
//                     } else {
//                       emailController.clear();
//                     }
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               if (isSelected[0])
//                 TextField(
//                   controller: phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'מספר טלפון',
//                     border: OutlineInputBorder(),
//                   ),
//                 )
//               else
//                 TextField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'כתובת מייל',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               SizedBox(height: 20),
//             if (isCodeSent)
//               Column(
//                 children: [
//                   TextField(
//                     controller: codeController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'קוד אימות',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   if (errorMessage != null)
//                     Text(
//                       errorMessage!,
//                       style: TextStyle(color: Colors.red),
//                     ),
//                 ],
//               ),
//             SizedBox(height: 20),
//             MyButten(
//               text: isCodeSent ? "אמת את הקוד" : "שלחו לי קוד אימות",
//               onTap: isCodeSent ? _verifyCode : _sendVerificationCode,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:coffee_shop/components/my_butten.dart';
import 'package:coffee_shop/const.dart';
import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/servises/mail_servise.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<bool> isSelected = [true, false];
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  

  void initState() {
    super.initState();
    phoneController.text = '+972';
  }

  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    if (isSelected[1]) {
      String email = emailController.text.trim();
      if (email.isNotEmpty) {
        await sendVerificationEmail(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('קוד אימות נשלח לאימייל שלך')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('נא להזין כתובת מייל')),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child: Image.asset('lib/images/espresso.png', height: 200),
              ),
              SizedBox(height: 48),
              Text(
                "ברוכים הבאים",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                    fontSize: 24),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "הזינו את מספר הטלפון או המייל על מנת להיכנס",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              SizedBox(height: 20),
              ToggleButtons(
                borderRadius: BorderRadius.circular(10),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("טלפון"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('מייל'),
                  ),
                ],
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                    if (isSelected[0]) {
                      phoneController.text = '+972';
                    } else {
                      emailController.clear();
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              if (isSelected[0])
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'מספר טלפון',
                    border: OutlineInputBorder(),
                  ),
                )
              else
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'כתובת מייל',
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 20),
              MyButten(
                text: "שלחו לי קוד אימות",
                onTap: _sendVerificationCode),
            ],
          ),
        ));
  }
}
