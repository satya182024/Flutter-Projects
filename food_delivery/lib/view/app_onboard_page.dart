import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/view/auth_page.dart';
import 'package:food_delivery/view/main_page.dart';

import '../models/onboard_model.dart';

class AppOnBoardPage extends StatefulWidget {
  const AppOnBoardPage({super.key});

  @override
  State<AppOnBoardPage> createState() => _AppOnBoardPageState();
}

class _AppOnBoardPageState extends State<AppOnBoardPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: onboards.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned(
                      top: -70,
                      left: 0,
                      right: 0,
                      child: FadeInDown(
                        delay: const Duration(milliseconds: 500),
                        child: Image.asset(
                          onboards[index].image,
                          width: 550,
                          height: 550,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 1.9,
                      child: FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                onboards[index].text1,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                onboards[index].text2,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
          Positioned(
            bottom: 180,
            left: 25,
            child: FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: Row(
                children: [
                  ...List.generate(
                      onboards.length,
                      (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 5,
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5)),
                          ))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthPage()));
                    },
                    color: korange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: MediaQuery.of(context).size.width - 50,
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
