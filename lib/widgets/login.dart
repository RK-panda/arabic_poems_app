import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:poems_arabic/main.dart';
import 'package:poems_arabic/widgets/bottom_nav.dart';
import 'package:poems_arabic/widgets/home.dart';
import 'package:poems_arabic/widgets/new_user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../token/token_class.dart';
import '../token/token_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool isLoading = false;
  // String token = '';

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  // login function
  // void postLogin(String email, String password) async {

  //   try {
  //     Response response = await post(
  //         Uri.parse('https://poams-app-eefd9d8f5585.herokuapp.com/users/login'),
  //         body: jsonEncode({
  //           "username": email,
  //           "password": password,
  //         }),
  //         headers: {
  //           "Content-Type": "application/json",
  //         });
  //     if (response.statusCode == 200) {

  //       var tokenResponse = jsonDecode(response.body.toString());
  //       print(tokenResponse);

  //       Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => BottomNavBarWidget()));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('الايميل او كلمة السر غير صحيحة'),
  //         ),
  //       );
  //       print('error occured ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('problem with ${e}');
  //   }
  // }

  void postLogin(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://poams-app-eefd9d8f5585.herokuapp.com/users/login'),
        body: jsonEncode({
          "username": email,
          "password": password,
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        var tokenResponse = jsonDecode(response.body);
        print(tokenResponse);

        final tokenValue = tokenResponse['token'];
        final token = Token(tokenValue);

        final tokenProvider =
            Provider.of<TokenProvider>(context, listen: false);
        tokenProvider.token = token;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavBarWidget()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('الايميل او كلمة السر غير صحيحة'),
          ),
        );
        print('error occurred ${response.statusCode}');
      }
    } catch (e) {
      print('problem with $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 104),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // label
                        const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        //back button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 94, 157, 36),
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    //email text field
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      // textDirection: TextDirection.ltr,
                      controller: emailController,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 247, 248, 251),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintText: 'البريد الالكتروني',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 150, 153, 154),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  //password text field
                  TextFormField(
                    obscureText: passwordVisible,
                    controller: passwordController,
                    // textDirection: TextDirection.ltr,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 247, 248, 251),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 14,
                        ),
                      ),
                      hintText: 'الرقم السري',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 150, 153, 154),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 226),
                    //login button
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('الايميل وكلمة المرور مطلوبة'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                postLogin(emailController.text,
                                    passwordController.text);
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            child: const Text(
                              'تسجيل دخول',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        if (isLoading)
                          Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // create account text button
                  Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ليس لديك حساب   .. ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 153, 154),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NewAccountScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'انشئ حساب',
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
