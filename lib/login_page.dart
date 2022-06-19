import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/homepage.dart';
import 'package:notes_app/signup_page.dart';
import 'auth_.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Center(child: Image.asset('assets/images/notes.png', height: 250,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
            )
          ),
          const Text("Notes",
            style: TextStyle(
            fontSize: 36.0,
            fontFamily: "Karla",
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15,),
          Text('Login In to your account',
                  style: TextStyle(fontSize: 20, color: Colors.grey[500])),
              SizedBox(height: 15),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2))
                    ]),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon:
                          Icon(Icons.email, color: Colors.deepOrangeAccent),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2))
                    ]),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password_outlined,
                          color: Colors.deepOrangeAccent),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                  bool shouldNavigate =
                      await signIn(emailController.text, passwordController.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                    }
                  },
                  child: Text('Login'),
                  ),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      signInWithGoogle(context);
                    },
                    child: Row(
                      children: [
                        const Text('Continue with google',
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Image.asset(
                            'assets/images/Google-Icon-PNG_rwscww.png', 
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                RichText(
            text: TextSpan(
                text: "Don't have an account?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontFamily: 'Karla'
                ),
                children: [
              TextSpan(
                  text: "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Karla',
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(() => SignUpPage()))
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }