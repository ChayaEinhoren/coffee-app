import 'package:coffee_shop/components/my_butten.dart';
import 'package:coffee_shop/const.dart';
import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/pages/home.dart';
import 'package:coffee_shop/servises/mail_servise.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<bool> isSelected = [true, false];
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  bool showVerificationField = false;
  String sentVerificationCode = '';

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
      String uid = "unique_user_id";
      if (email.isNotEmpty) {
        String code =
            await sendVerificationEmail(email, uid); // שמירת הקוד שנשלח
        setState(() {
          sentVerificationCode = code;
          showVerificationField = true;
        });
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

  Future<void> _verifyCode() async {
    String enteredCode = verificationCodeController.text.trim();
    if (enteredCode == sentVerificationCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('***אימות הצליח***')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('קוד האימות שגוי')),
      );
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
                    showVerificationField =
                        false; 
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
              else if (isSelected[1])
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'כתובת מייל',
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 20),
              MyButten(text: "שלחו לי קוד אימות", onTap: _sendVerificationCode),
              if (showVerificationField &&
                  isSelected[1])
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: verificationCodeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'הזינו את הקוד',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MyButten(
                        text: "אמתו קוד",
                        onTap: _verifyCode
                    ), 
                  ],
                ),
            ],
          ),
        ));
  }
}

// Future<String> sendVerificationEmail(String email) async {
//   String code = generateVerificationCode();
//   // String code = "123456"; // For testing purposes, replace with generateVerificationCode() when ready.
//   String subject = "Your Verification Code";
//   String body = "Your verification code is: $code";

//   await sendEmail(email, subject, body);
//   return code; // החזרת הקוד שנשלח
// }