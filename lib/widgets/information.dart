import 'package:flutter/material.dart';
import 'package:poems_arabic/main.dart';

import 'bottom_nav.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
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
                          Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => BottomNavBarWidget()));
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
                          'تعليمات الاستخدام',
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
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 319,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(10, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: const Color.fromARGB(10, 255, 255, 255)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Center(
                          child: Text(
                            'افصل شطري البيت بعلامة "=" أما اذا كان البيت يتكون من شطر واحد فلا تستخدم هذه العلامة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 70,
                        width: 319,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(10, 0, 0, 0),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: const Color.fromARGB(10, 255, 255, 255)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Center(
                            child: Text(
                              'تستطيع تنسيق الـ 5 قصائد مجانا . ثم يمكنك الأشتراك في التطبيق لتنسيق عدد لا محدود من القصائد وايقاف الأعلانات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
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
    );
  }
}
