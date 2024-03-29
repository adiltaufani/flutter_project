import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/common/widgets/custom_password_field.dart';
import 'package:flutter_project/common/widgets/custom_texfield.dart';
import 'package:flutter_project/features/auth/screens/auth_screen.dart';
import 'package:flutter_project/features/auth/screens/home_screen.dart';
import 'package:flutter_project/features/auth/services/firebase_auth_service.dart';
import 'package:flutter_project/features/auth/services/google_auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthService _auth = FirebaseAuthService();
  final _signInFormKey = GlobalKey<FormState>();
  final GoogleAuthService authService = GoogleAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 40),
              child: const Text(
                'Book-it',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OutfitBlod'),
              ),
            ),
            const Text(
              'Book with Ease, Anytime, Anywhere!',
              style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'OutfitLight'),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _signInFormKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: 'E-mail',
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: CustomPasswordField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_signInFormKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontFamily: 'OutfitBlod',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 150, vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 370,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => authService.signInWithGoogle(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        // Tetap gunakan padding yang sesuai
                        padding: const EdgeInsets.symmetric(
                            horizontal: 105, vertical: 10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Widget untuk gambar
                          Padding(
                            padding: const EdgeInsets.only(right: 1.0),
                            child: Image.asset(
                              'assets/images/google-logo.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          // Widget untuk teks
                          Text(
                            'Login with Google',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OutfitBlod',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an accont?",
                        style: TextStyle(
                          fontFamily: 'OutfitBlod',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0077B2),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Tambahkan logika yang ingin Anda jalankan ketika teks ditekan di sini
                          // Misalnya, untuk menavigasi ke layar login, Anda dapat menggunakan Navigator
                          Navigator.pushNamed(context, AuthScreen.routeName);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'OutfitBlod',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("Succesfully created");
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      print('some error occured');
    }
  }
}
