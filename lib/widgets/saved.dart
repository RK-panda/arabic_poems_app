import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../token/token_provider.dart';
import 'bottom_nav.dart';

class SavedItemsScreen extends StatefulWidget {
  // final String token;
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  // final List<Color> tileColors = [
  //   Color.fromARGB(73, 255, 255, 255),
  //   // Color.fromARGB(72, 87, 87, 87),
  // ];

  Future<List<dynamic>> getPoems() async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final token = tokenProvider.token;
    print(token);

    if (token == null) {
      print('Token not available');
    }

    final response = await http.get(
      Uri.parse('https://poams-app-eefd9d8f5585.herokuapp.com/poems/'),
      headers: {
        'Authorization': 'Bearer ${token?.value}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        height: double.infinity,
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
                          'المحفوظات',
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: FutureBuilder<List<dynamic>>(
                    future: getPoems(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            // final tileColor =
                            //     tileColors[index % tileColors.length];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Container(
                                // color: tileColor,
                                // padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(73, 255, 255, 255),
                                ),
                                child: ListTile(
                                  title: Text(
                                    item['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item['content'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),

              // poems list
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Container(
              //     height: 120,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Color.fromARGB(73, 255, 255, 255),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           // Text(
              //           //   'عنوان القصيدة',
              //           //   style: TextStyle(
              //           //     color: Colors.white,
              //           //     fontSize: 10,
              //           //     fontWeight: FontWeight.bold,
              //           //   ),
              //           // ),
              //           FutureBuilder<List<dynamic>>(
              //             future: getPoems(),
              //             builder: (context, snapshot) {
              //               if (snapshot.hasData) {
              //                 final data = snapshot.data!;
              //                 return ListView.builder(
              //                   itemCount: data.length,
              //                   itemBuilder: (context, index) {
              //                     final item = data[index];
              //                     return ListTile(
              //                       title: Text(
              //                         item['name'],
              //                         style: TextStyle(
              //                           color: Colors.white,
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       subtitle: Text(
              //                         item['content'],
              //                         style: TextStyle(
              //                           color: Colors.white,
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                 );
              //               } else if (snapshot.hasError) {
              //                 return Text('Error: ${snapshot.error}');
              //               } else {
              //                 return CircularProgressIndicator();
              //               }
              //             },
              //           ),
              //           // Padding(
              //           //   padding: const EdgeInsets.only(top: 10),
              //           //   child: Text(
              //           //     'نص القصيدة',
              //           //     style: TextStyle(
              //           //       color: Colors.white,
              //           //       fontSize: 12,
              //           //     ),
              //           //   ),
              //           // ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
