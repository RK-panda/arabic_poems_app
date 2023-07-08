import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poems_arabic/animated_button.dart';
import 'package:poems_arabic/icons_custom.dart';
import 'package:poems_arabic/main.dart';
import 'package:poems_arabic/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:image_picker/image_picker.dart';

import '../expandFAB.dart';
import '../token/token_class.dart';
import '../token/token_provider.dart';
import 'bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  // final String token;
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
  late String chosenFormatText;

  File? backgroundImage;
  String? savedImagePath;
  GlobalKey globalKey = GlobalKey();

  // late String token;

  @override
  void initState() {
    super.initState();
    // loadToken();
  }

  //save poem function
  void savePoem(String label, String body) async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final token = tokenProvider.token;

    if (token == null) {
      print('Token not available');
      return;
    }
    try {
      Response response = await post(
        Uri.parse('https://poams-app-eefd9d8f5585.herokuapp.com/poems/'),
        body: jsonEncode({
          "name": label,
          "content": body,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token.value}",
        },
      );
      if (response.statusCode == 200) {
        var tokenResponse = jsonDecode(response.body);
        print(tokenResponse);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavBarWidget()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم حفظ القصيدة'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ, حاول لاحقاً'),
          ),
        );
        print('error occurred ${response.statusCode}');
      }
    } catch (e) {
      print('problem with $e');
    }
  }

  //pick image from gallery function
  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        backgroundImage = File(pickedFile.path);
      });
      saveContainerAsImage();
    }
  }

  //save image function
  Future<void> saveContainerAsImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/combined_image.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(bytes);

      setState(() {
        savedImagePath = imagePath;
      });

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveImage(bytes);
      if (result['isSuccess']) {
        print('Image saved to gallery: ${result['filePath']}');
      } else {
        print('Failed to save image: ${result['errorMessage']}');
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  //share the image to social media

  // void shareImage() async {
  //   if (savedImagePath != null) {
  //     final String savedImagePath1 = savedImagePath!;
  //     await Share.shareFiles([savedImagePath1], text: 'قصيدة جديدة!');
  //   }
  // }

  //select image from gallery
  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        backgroundImage = File(pickedImage.path);
      });
    }
  }

//share to social media function
  Future<void> shareContent(String text, [String? imagePath]) async {
    try {
      if (imagePath != null) {
        await Share.shareFiles([imagePath], text: text);
      } else {
        await Share.share(text);
      }
    } catch (e) {
      print('Error sharing content: $e');
    }
  }

  //select image from gallery
  // Future<void> selectImageAndShare(BuildContext context) async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     final imagePath = pickedImage.path;
  //     await shareImage(context, imagePath);
  //   }
  // }
  // Future<void> pickAndShareImage() async {
  //   final imagePicker = ImagePicker();
  //   final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     final imageFile = File(pickedFile.path);
  //     await Share.shareFiles([imageFile.path], text: 'Check out this image!');
  //   }
  // }

  // Future<void> captureAndShareImage() async {
  //   RenderRepaintBoundary boundary =
  //       globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   final image = await boundary.toImage();
  //   final byteData = await image.toByteData(format: ImageByteFormat.png);
  //   final pngBytes = byteData!.buffer.asUint8List();

  //   final tempDir = await getTemporaryDirectory();
  //   final tempFile = await File('${tempDir.path}/temp_image.png').create();
  //   await tempFile.writeAsBytes(pngBytes);

  //   await Share.shareFiles([tempFile.path], text: 'Check out this image!');
  // }

//share image to social
  // Future<void> shareImage(BuildContext context, String imagePath) async {
  //   await Share.shareFiles([imagePath]);

  //   // Optional: Reset the selected image after sharing
  //   // setState(() {
  //   //   backgroundImage = null;
  //   // });
  // }

  //share options dialog
  Future<void> showShareDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'مشاركة',
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'كيف تريد مشاركة القصيدة؟',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (chosenFormatText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('لا يوجد نص لمشاركته'),
                      ),
                    );
                  } else {
                    // shareContent(chosenFormatText);
                  }
                },
                child: const Text(
                  'مشاركة نص',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {
                  // selectImageAndShare(context);
                  // pickAndShareImage();
                  // captureAndShareImage();
                },
                child: const Text(
                  'مشاركة صورة',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        });
  }

  // review dialog function
  Future<void> showPoemDialog() async {
    // formatsFunction();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              poemLabelController.text,
              style: const TextStyle(fontSize: 14),
            ),
            content: SingleChildScrollView(
              child: formatsFunction(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (savedImagePath == null || backgroundImage == null) {
                    savePoem(
                        poemLabelController.text, poemStringController.text);

                    print("null image value");
                  } else {
                    savePoem(
                        poemLabelController.text, poemStringController.text);
                    saveContainerAsImage();
                    print("image value not null");
                  }
                },
                child: const Text(
                  'حفظ',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'الغاء',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 127, 95, 133),
                  ),
                ),
              ),
            ],
          );
        });
  }

  // poems formats function
  formatsFunction() {
    Widget poemTextWidget; // Widget to hold the formatted poem text

    if (selected == 0 /*first format*/) {
      firstFormatStr = poemStringController.text
          .replaceAll('=', ' ${seperatorController.text} ');
      finalText1 = firstFormatStr;
      chosenFormatText = firstFormatStr;
      poemTextWidget = Text(
        firstFormatStr,
        style: const TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else if (selected == 1 /*second format */) {
      poemTextWidget = Text(
        'Your second format implementation',
        style: const TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else if (selected == 2 /* third format*/) {
      thirdFormatStr = poemStringController.text.replaceAll('=', '\n');
      List<String> lines = thirdFormatStr.split('\n');
      var concatinate = StringBuffer();
      for (var element in lines) {
        concatinate.write('$element\n');
      }
      finalText3 = concatinate.toString();
      chosenFormatText = concatinate.toString();

      poemTextWidget = Text(
        thirdFormatStr,
        style: const TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        'من فضلك ادخل نص القصيدة',
        style: const TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      );
    }

    return backgroundImage == null
        ? Center(
            child: poemTextWidget,
          )
        : RepaintBoundary(
            key: globalKey,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    backgroundImage!,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(child: poemTextWidget),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

    // Access the token
    final Token? token = tokenProvider.token;
    print(token);
    // print(widget.token);
    return Scaffold(
      endDrawer: SideMenuDrawer(),
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
              const Text(
                'مشاركة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              ActionButton(
                onPressed: () {
                  print('ABC');
                  // showShareDialog();

                  if (chosenFormatText.isNotEmpty) {
                    // Share.share(chosenFormatText);
                    shareContent(chosenFormatText);
                  } else {
                    // shareContent(chosenFormatText);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('لا يوجد نص لمشاركته'),
                      ),
                    );
                  }

                  // if (savedImagePath == null || backgroundImage == null) {
                  //   //share text only
                  //   shareContent(chosenFormatText);
                  // } else {
                  //   shareContent(finalText1, backgroundImage!.path);
                  // }
                },
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
              const Text(
                'اضافة صورة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              ActionButton(
                onPressed: () {
                  print('DEF');
                  pickImageFromGallery();
                },
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
              const Text(
                'حفظ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              ActionButton(
                onPressed: () {
                  showPoemDialog();
                  print('GHI');
                },
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
                            // Center(
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         if (flag0 == true) {
                            //           FirstFormatFun();
                            //         }
                            //       });
                            //     },
                            //     child: Text(
                            //       'مراجعة',
                            //       style: TextStyle(
                            //         color: primaryColor,
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     style: ButtonStyle(
                            //       backgroundColor:
                            //           MaterialStateProperty.all(Colors.white),
                            //     ),
                            //   ),
                            // ),
                            // Center(
                            //   child: Column(
                            //     children: [
                            //       Container(
                            //         width: double.infinity,
                            //         padding: EdgeInsets.all(10),
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           color: Color.fromARGB(255, 246, 255, 247),
                            //         ),
                            //         child: Align(
                            //           alignment: Alignment.topRight,
                            //           child: FirstFormatFun(),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            //////////////////////////

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
