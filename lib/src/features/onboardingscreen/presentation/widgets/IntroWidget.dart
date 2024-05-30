import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylast2gproject/src/features/BottomNavBar/presentation/pages/BottomNavHome.dart';

import '../../../../core/theme/theme.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.color,
    required this.title,
    required this.skip,
    required this.image,
    required this.onTab,
    required this.index,
  });

  final String color;
  final String title;
  final bool skip;
  final String image;
  final VoidCallback onTab;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BoxColor(
      color: color,
      image: image,
      index: index,
      title: title,
      skip: skip,
      onTab: onTab,
    );
  }
}

class BoxColor extends StatelessWidget {
  const BoxColor({
    super.key,
    required this.color,
    required this.image,
    required this.index,
    required this.title,
    required this.skip,
    required this.onTab,
  });

  final String color;
  final String image;
  final int index;
  final String title;
  final bool skip;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: hexToColor(color),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.86,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: index == 0
                      ? const Radius.circular(150)
                      : const Radius.circular(0),
                  topRight: index == 1
                      ? const Radius.circular(150)
                      : const Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    const SizedBox(height: 62),
                    Text(
                      title,
                      style: GoogleFonts.aclonica( // You can change 'lato' to any Google Font you prefer
        textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: skip
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.offAll(() => BottomNavBarV2());
                          },
                          child: const Text(
                            'Skip Now',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTab,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: hexToColor(color),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.arrow_circle_right,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 46,
                      child: MaterialButton(
                        
                        color: hexToColor(color),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          Get.offAll(() => BottomNavBarV2());
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white),
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
