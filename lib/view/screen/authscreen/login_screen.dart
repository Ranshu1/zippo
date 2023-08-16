import 'package:flutter/material.dart';
import 'package:zippo/constants.dart';
import 'package:zippo/view/screen/authscreen/signup_screen.dart';
import 'package:zippo/view/screen/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Zippo",
              style: TextStyle(
                  fontSize: 35, fontWeight: FontWeight.w900, color: buttonColor),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: TextInputField(
                  controller: _emailController,
                  labelText: "Email",
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: TextInputField(
                  controller: _passController,
                  keyboardType: TextInputType.text,
                  labelText: "Password",
                  hintText: "Enter your password",
                  isObsecured: true,
                  icon: Icons.password),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(color: buttonColor),
              child: InkWell(
                  onTap: () => authController.loginUser(_emailController.text, _passController.text),
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ))),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: buttonColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
