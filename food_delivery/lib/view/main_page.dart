import 'package:flutter/material.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/view/food_facts_page.dart';
import 'package:food_delivery/view/home_page.dart';
import 'package:food_delivery/view/profile_page.dart';

import '../models/bottom_icon_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List selectedPage = [
    const HomePage(),
    // const Center(child: Text('Message Page')),
    const FoodFactsPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 15),
        height: 65,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
                bottomIcons.length,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            currentIndex == index
                                ? bottomIcons[index].selected
                                : bottomIcons[index].unselected,
                            color: kblack,
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Container(
                          //   decoration: const BoxDecoration(
                          //       color: kblack, shape: BoxShape.circle),
                          //   width: currentIndex == index ? 7 : 0,
                          //   height: currentIndex == index ? 7 : 0,
                          // )
                        ],
                      ),
                    ))
          ],
        ),
      ),
      body: selectedPage[currentIndex],
    );
  }
}
