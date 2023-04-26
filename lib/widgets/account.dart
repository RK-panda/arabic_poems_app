import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poems_arabic/main.dart';

import 'bottom_nav.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool passwordVisible2 = false;
  bool value = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible2 = true;
  }

  //alert dialog function

  showAlertDialog(BuildContext context) {
    Widget cancelButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        'لا',
        style: TextStyle(
          fontSize: 9,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
    Widget confirmBiutton = ElevatedButton(
      onPressed: () {},
      child: Text(
        'نعم',
        style: TextStyle(
          color: primaryColor,
          fontSize: 9,
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        side: MaterialStateProperty.all(BorderSide(
            color: primaryColor, width: 0.5, style: BorderStyle.solid)),
      ),
    );
    AlertDialog alert = AlertDialog(
      content: Text(
        'هل تريد بالفعل حذف الحساب؟',
        style: TextStyle(
          color: primaryColor,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        confirmBiutton,
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: EdgeInsets.only(left: 50, right: 50),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 136,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 38, right: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BottomNavBarWidget()));
                          },
                          icon: const Icon(
                            Icons.close_sharp,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20, top: 8),
                          child: Text(
                            'الحساب',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 48,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.jpg'),
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: InkWell(
                                    onTap: () {
                                      // here add add image from gallery function
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            50,
                                          ),
                                        ),
                                        color: Colors.amber,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(2, 4),
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                showAlertDialog(context);
                              },
                              child: const Text(
                                'حذف الحساب',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
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
                            hintText: 'الرقم السري القديم',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 150, 153, 154),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      //repeat password text field
                      TextFormField(
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
                          hintText: 'الرقم السري الجديد',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 150, 153, 154),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 140),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'تعديل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
