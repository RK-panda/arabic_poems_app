import 'package:flutter/material.dart';

import '../main.dart';
import 'bottom_nav.dart';
import 'new_user.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
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
                    padding: const EdgeInsets.only(top: 20, bottom: 106),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // label
                        const Text(
                          'رقم سري جديد',
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
                                builder: (context) => NewAccountScreen()));
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
                  //new password text field
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
                  Padding(
                    padding: const EdgeInsets.only(top: 360),
                    //login button
                    child: SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          // login api call here
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => BottomNavBarWidget()));
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
                          'تعديل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
