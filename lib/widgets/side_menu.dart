import 'package:flutter/material.dart';
import 'package:poems_arabic/main.dart';
import 'package:poems_arabic/widgets/account.dart';
import 'package:poems_arabic/widgets/login.dart';

import 'bottom_nav.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'مرحبا, ',
                        style: TextStyle(color: primaryColor, fontSize: 12),
                      ),
                      Text(
                        // get this name from backend
                        'محمد',
                        style: TextStyle(color: primaryColor, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: ListTile(
                  contentPadding: EdgeInsets.all(4),
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.home_outlined,
                    color: primaryColor,
                    size: 16,
                  ),
                  title: const Text(
                    'الرئيسية',
                    style: TextStyle(color: primaryColor, fontSize: 10),
                  ),
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavBarWidget()))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: ListTile(
                  contentPadding: EdgeInsets.all(4),
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.person_outlined,
                    color: primaryColor,
                    size: 16,
                  ),
                  title: const Text(
                    'الحساب',
                    style: TextStyle(color: primaryColor, fontSize: 10),
                  ),
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AccountScreen()))
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26, top: 280),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: ListTile(
                  contentPadding: EdgeInsets.all(4),
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: primaryColor,
                    size: 16,
                  ),
                  title: const Text(
                    'تسجيل خروج',
                    style: TextStyle(color: primaryColor, fontSize: 10),
                  ),
                  onTap: () => {
                    // here add logout credentials
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()))
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
