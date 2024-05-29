import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mylast2gproject/src/core/constants/weatherConst.dart';
import 'package:mylast2gproject/src/features/weatherhome/data/models/weatherModel.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/widgets/weather_cold.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/widgets/weather_hot.dart';

class WeatherHomeController extends GetxController {
  final TextEditingController cityController = TextEditingController();
  RxBool isLoading = false.obs;
  Rx<Weatherdata?> weatherData = Rx<Weatherdata?>(null);
  RxBool isSwitched = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedState();
  }

  void loadSavedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cityController.text = prefs.getString('city') ?? 'cairo';
    isSwitched.value = prefs.getBool('switchState') ?? false;
    getData();
  }

  void saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', cityController.text);
    prefs.setBool('switchState', isSwitched.value);
  }

  Future<void> getData() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${cityController.text}&appid=509dc5d730ff2dd6003b22f30ae93313'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData != null) {
          weatherData.value = Weatherdata.fromJson(jsonData);
          isLoading.value = false;
          checkTemperatureAndSendAlert();
        }
      } else {
        // Handle non-200 status code here
      }
    } catch (e) {
      // Handle error here
    }
  }

  void checkTemperatureAndSendAlert() {
    if (weatherData.value != null) {
      double temperature = weatherData.value!.main.temp;
      if (temperature > 35) {
        Get.defaultDialog(
          title: 'تنبيه!',
          content: Text('درجة الحرارة مرتفعة جداً، يرجى اتخاذ الاحتياطات اللازمة.'),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('حسنًا'),
          ),
        );
      } else if (temperature < 8) {
        Get.defaultDialog(
          
          title: 'تنبيه!',
          content: Text('درجة الحرارة منخفضة جداً، المحاصيل قد تكون معرضة للتلف.'),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('حسنًا'),
          ),
        );
      }
    }
  }

  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
    saveState();
  }
}
