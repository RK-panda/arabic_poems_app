import 'package:flutter/material.dart';
import 'package:poems_arabic/widgets/bottom_nav.dart';
import 'package:poems_arabic/widgets/login.dart';
import 'package:poems_arabic/widgets/new_password.dart';

import '../main.dart';
import 'home.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool passwordVisible2 = false;
  bool value = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible2 = true;
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
                          'حساب جديد',
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
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
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 247, 248, 251),
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
                  //repeat password text field
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      obscureText: passwordVisible2,
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
                              passwordVisible2 = !passwordVisible2;
                            });
                          },
                          icon: Icon(
                            passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 14,
                          ),
                        ),
                        hintText: 'تأكيد الرقم السري',
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 150, 153, 154),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: primaryColor,
                          value: this.value,
                          onChanged: (value) {
                            setState(
                              () {
                                this.value = value!;
                              },
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.zero,
                          child: Text(
                            'تذكرني',
                            style: TextStyle(
                              color: Color.fromARGB(255, 150, 153, 154),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewPasswordScreen()));
                            },
                            child: const Text(
                              'هل نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 130),
                    //create user button
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // login api call here
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBarWidget()));
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        child: const Text(
                          'انشئ حساب',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // create account text button
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'لديك حساب بالفعل  .. ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 153, 154),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'سجل دخول',
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
