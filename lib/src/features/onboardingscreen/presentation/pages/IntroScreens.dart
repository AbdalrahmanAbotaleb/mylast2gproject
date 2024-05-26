import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/theme.dart'; // Assuming this is where hexToColor is defined
import '../controllers/intro_controller.dart';
import '../widgets/IntroWidget.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IntroController introController = Get.put(IntroController());

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: introController.pageController,
            itemCount: introController.pages.length,
            scrollBehavior: AppScrollBehavior(),
            onPageChanged: introController.onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              final page = introController.pages[index];
              return IntroWidget(
                index: index,
                color: page['color'],
                title: page['title'],
                image: page['image'],
                skip: page['skip'],
                onTab: introController.onNextPage,
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.75,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    introController.pages.length,
                    (index) => Obx(() => _buildIndicator(
                        isActive: introController.activePage.value == index,
                        color: introController.pages[index]['color'])),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator({required bool isActive, required String color}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 6 : 8,
      width: isActive ? 42 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isActive ? hexToColor(color) : Colors.grey.shade100,
      ),
    );
  }
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF' + hex; // 8 char with 100% opacity
  }
  return Color(int.parse(hex, radix: 16));
}
