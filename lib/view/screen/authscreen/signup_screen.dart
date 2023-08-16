import 'package:flutter/material.dart';
import 'package:zippo/constants.dart';
import 'package:zippo/controller/authController.dart';
import 'package:zippo/view/screen/widgets/text_input_field.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Zippo",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: buttonColor),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: backgroundColor,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          authController.pickImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    labelText: "Name",
                    hintText: "Enter your name",
                    icon: Icons.person),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextInputField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Email",
                    hintText: "Enter your email",
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
                    onTap: () {
                      authController.registerUser(
                        _nameController.text,
                        _emailController.text,
                        _passController.text,
                        authController.ProfilePhoto,
                      );
                    },
                    child: Center(
                        child: Text(
                      "Sign up",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ))),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                      onTap: () {
                        print("Login");
                      },
                      child: Text(
                        "Login",
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
      ),
    );
  }
}
