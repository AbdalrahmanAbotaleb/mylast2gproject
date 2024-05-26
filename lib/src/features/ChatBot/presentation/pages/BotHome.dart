// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylast2gproject/src/features/ChatBot/presentation/pages/chat.dart';

class HomeBot extends StatelessWidget {
  const HomeBot();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset("assets/images/bot.png"),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Need More Advices ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF394929),
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: const [
                    Text(
                      'Our AI_Chat is available to help you.',
                      style: TextStyle(
                        color: Color(0xff58793B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' with any plant-related problems you may be facing. ',
                      style: TextStyle(
                        color: Color(0xff58793B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'may be facing',
                      style: TextStyle(
                        color: Color(0xff58793B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  ChatPage());
                  },
                  child: Container(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Text(
                        "Ask Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.43,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF569033),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 32,
                          offset: Offset(0, 20),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
