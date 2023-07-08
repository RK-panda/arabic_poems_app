import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../main.dart';
import 'bottom_nav.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  bool status = false;
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
                          'الاشتراكات',
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
                padding: const EdgeInsets.only(top: 46, bottom: 60),
                child: FlutterSwitch(
                    activeText: 'شهـري',
                    inactiveText: 'سنـوي',
                    valueFontSize: 18,
                    activeTextColor: primaryColor,
                    inactiveTextColor: primaryColor,
                    width: 175,
                    height: 60,
                    borderRadius: 25,
                    toggleColor: Color.fromARGB(255, 238, 238, 238),
                    toggleSize: 56,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    showOnOff: true,
                    value: status,
                    onToggle: (value) {
                      // here add switch widgets function or flag
                      setState(() {
                        status = value;
                      });
                    }),
              ),
              status
                  ? Container(
                      // if statues is active (monthely subscribe)
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Stack(
                              fit: StackFit.loose,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              children: [
                                Container(
                                  width: 147,
                                  height: 193,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.amber,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  child: Container(
                                    width: 147,
                                    height: 183,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(240, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8, top: 20),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/star.png'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              'الباقة الفضية',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14, right: 24, bottom: 14),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'SAR',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '4.99',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              'اشترك الان',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fixedSize: Size(
                                                double.maxFinite,
                                                double.minPositive,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      // if statues is diactivated (yearly subscribs)
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Stack(
                            fit: StackFit.loose,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            children: [
                              Container(
                                width: 147,
                                height: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                child: Container(
                                  width: 147,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(240, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 8, top: 20),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/star.png'),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(
                                            'الباقة الذهبية',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 24),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: primaryColor,
                                                size: 10,
                                              ),
                                              Text(
                                                'ايقاف الأعلانات',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 168, 168, 168),
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 24),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: primaryColor,
                                                size: 10,
                                              ),
                                              Text(
                                                'عدد لا محدود من\n التنسيقات',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 168, 168, 168),
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14, right: 24, bottom: 14),
                                          child: Row(
                                            children: [
                                              Text(
                                                'SAR',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '12.99',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'أفضل سعر!',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 0, 255, 71),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            fixedSize: Size(
                                              double.maxFinite,
                                              double.minPositive,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Stack(
                              fit: StackFit.loose,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              children: [
                                Container(
                                  width: 147,
                                  height: 193,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.amber,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  child: Container(
                                    width: 147,
                                    height: 183,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(240, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8, top: 20),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/star.png'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              'الباقة البلاتينية',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14, right: 24, bottom: 14),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'SAR',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '28.99',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              'اشترك الان',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              fixedSize: Size(
                                                double.maxFinite,
                                                double.minPositive,
                                              ),
                                            ),
                                          ),
                                        ],
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
            ],
          ),
        ),
      ),
    );
  }
}
