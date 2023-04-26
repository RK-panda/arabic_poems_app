import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:poems_arabic/main.dart';
import 'package:poems_arabic/widgets/home.dart';
import 'package:poems_arabic/widgets/information.dart';
import 'package:poems_arabic/widgets/saved.dart';
import 'package:poems_arabic/widgets/subscribe.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int selectedIndex = 0;
  final screens = [
    HomeScreen(),
    SubscribeScreen(),
    SavedItemsScreen(),
    InformationScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconBottomBar(
                    text: 'الرئيسية',
                    icon: Icons.home_outlined,
                    selected: selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  IconBottomBar(
                    text: 'الاشتراك',
                    icon: Icons.ads_click_outlined,
                    selected: selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                  IconBottomBar(
                    text: 'المحفوظات',
                    icon: Icons.bookmark_outline,
                    selected: selectedIndex == 2,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                  ),
                  IconBottomBar(
                    text: 'تعليمات',
                    icon: Icons.info_outline,
                    selected: selectedIndex == 3,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
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

class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  const IconBottomBar(
      {super.key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Color.fromARGB(83, 109, 34, 122),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            height: .1,
            color: selected ? primaryColor : Color.fromARGB(83, 109, 34, 122),
          ),
        ),
      ],
    );
  }
}
