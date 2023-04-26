import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:poems_arabic/animated_button.dart';
import 'package:poems_arabic/icons_custom.dart';
import 'package:poems_arabic/main.dart';
import 'package:poems_arabic/widgets/side_menu.dart';

import '../expandFAB.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int? selected = null;
  TextEditingController poemStringController = TextEditingController();
  TextEditingController poemLabelController = TextEditingController();
  TextEditingController seperatorController = TextEditingController();

  int selected = 0;

  late String firstFormatStr;
  late String secondFormatStr;
  late String thirdFormatStr;

  late String finalText1;
  late String finalText2;
  late String finalText3;

  bool flag0 = false;
  bool flag1 = false;
  bool flag2 = false;

  // Widget iconList(int index, {String? text, IconData? icon}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 60, right: 60),
  //     child: InkResponse(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             icon,
  //             color: selected == index ? Colors.white : null,
  //           ),
  //         ],
  //       ),
  //       onTap: () => setState(
  //         () {
  //           selected = index;
  //         },
  //       ),
  //     ),
  //   );
  // }

  FirstFormatFun() {
    if (flag0 == true /*first format*/) {
      firstFormatStr = poemStringController.text
          .replaceAll('=', ' ' + seperatorController.text + ' ');
      finalText1 = poemLabelController.text +
          '\n' +
          '-------------------' +
          '\n' +
          firstFormatStr;
      return SizedBox(
        width: 180 * 2,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Expanded(
            child: Text(
              finalText1,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                // fontFamily: "KawkabMono",
                color: primaryColor,
                fontSize: 9,
              ),
              // style: GoogleFonts.tajawal(fontSize: 12),
              // TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const SideMenuDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            'اضافة قصيدة',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 120,
        children: [
          Row(
            children: [
              Text(
                'مشاركة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              ActionButton(
                onPressed: () => print('ABC'),
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'اضافة صورة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              ActionButton(
                onPressed: () => print('DEF'),
                icon: const Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'حفظ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              ActionButton(
                onPressed: () => print('GHI'),
                icon: const Icon(
                  Icons.save_outlined,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Container(
          color: primaryColor,
          height: double.maxFinite,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 79,
                        width: 67,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: Text(
                                'عنوان القصيدة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // poem label textfield
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: poemLabelController,
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  hintText: 'اكتب النص هنا',
                                  hintTextDirection: TextDirection.rtl,
                                  hintStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.only(bottom: 12, top: 30),
                              child: Text(
                                'القصيدة كاملة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // poem text textfield
                            SizedBox(
                              height: 170,
                              child: TextFormField(
                                controller: poemStringController,
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  hintText: 'اكتب النص هنا',
                                  hintTextDirection: TextDirection.rtl,
                                  hintStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12, top: 30),
                              child: Text(
                                'اختر نوع التنسيق',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //Format Selection
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // iconList(
                                //   0,
                                //   text: 'سطرين',
                                //   icon: Icon(MyFlutterApp.double),
                                // ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        selected = 0;
                                        //////////////////////////////////////////////////////
                                        flag0 = true;
                                      }),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        color: selected == 0
                                            ? Colors.grey
                                            : Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/multiline.png'),
                                      ),
                                    ),
                                    const Text(
                                      'سطرين',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 60),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        selected = 1;
                                      }),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        color: selected == 1
                                            ? Colors.grey
                                            : Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/concludes.png'),
                                      ),
                                    ),
                                    const Text(
                                      'متداخل',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 60),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        selected = 2;
                                      }),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        color: selected == 2
                                            ? Colors.grey
                                            : Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/singles.png'),
                                      ),
                                    ),
                                    const Text(
                                      'منفصل',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'اكتب نوع الفاصل',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: SizedBox(
                                      height: 26,
                                      width: 57,
                                      child: TextFormField(
                                        controller: seperatorController,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          hintText: '.....',
                                          hintTextDirection: TextDirection.rtl,
                                          hintStyle: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                            letterSpacing: 6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ExpandableFab(
                            //   distance: 20,
                            //   children: [
                            //     ActionButton(
                            //       onPressed: () => print('ABC'),
                            //       icon: const Icon(Icons.format_size),
                            //     ),
                            //     ActionButton(
                            //       onPressed: () => print('DEF'),
                            //       icon: const Icon(Icons.insert_photo),
                            //     ),
                            //     ActionButton(
                            //       onPressed: () => print('GHI'),
                            //       icon: const Icon(Icons.videocam),
                            //     ),
                            //     ActionButton(
                            //       onPressed: () => print('DEF'),
                            //       icon: const Icon(Icons.camera_enhance),
                            //     ),
                            //     ActionButton(
                            //       onPressed: () => print('GHI'),
                            //       icon: const Icon(Icons.camera),
                            //     ),
                            //   ],
                            // ),

                            // AnimatedFabButton(
                            //   onPressed: () {},
                            //   icon: Icons.add,
                            // ),

                            // SpeedDial(
                            //   marginBottom: 10,
                            //   icon: Icons.add,
                            //   activeIcon: Icons.close,
                            //   backgroundColor: Colors.white,
                            //   foregroundColor: primaryColor,
                            //   activeBackgroundColor: Colors.white,
                            //   activeForegroundColor: primaryColor,
                            //   buttonSize: 56,
                            //   visible: true,
                            //   closeManually: false,
                            //   curve: Curves.bounceIn,
                            //   overlayColor: Colors.black,
                            //   overlayOpacity: 0.8,
                            //   onOpen: () => print('Opened Button'),
                            //   onClose: () => print('Closed Button'),
                            //   elevation: 8,
                            //   shape: CircleBorder(),
                            //   children: [
                            //     SpeedDialChild(
                            //       //speed dial child
                            //       child: Icon(Icons.accessibility),
                            //       backgroundColor: Colors.red,
                            //       foregroundColor: Colors.white,
                            //       label: 'First Menu Child',
                            //       labelStyle: TextStyle(fontSize: 18.0),
                            //       onTap: () => print('FIRST CHILD'),
                            //       onLongPress: () =>
                            //           print('FIRST CHILD LONG PRESS'),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
