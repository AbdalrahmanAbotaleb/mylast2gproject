import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylast2gproject/src/core/theme/theme_controller.dart';
import 'package:mylast2gproject/src/features/splashscreen/presentation/pages/SplashScreen.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/pages/weatherui.dart';

import 'src/features/weatherhome/presentation/pages/welcome.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the ThemeController
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/main',
      getPages: [
        GetPage(name: '/main', page: () => MainScreen()),
        GetPage(name: '/weather', page: () => WeatherHomePage()),
      ],
        title: 'PlantDiseasesX',
        theme: ThemeData(
          useMaterial3: true,
          brightness: themeController.isDarkTheme.value
              ? Brightness.dark
              : Brightness.light,
        ),
        home: SplashScreenPage(),
      );
    });
  }
}
