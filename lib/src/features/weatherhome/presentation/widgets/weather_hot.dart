import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mylast2gproject/src/core/constants/weatherConst.dart';
import 'package:mylast2gproject/src/features/weatherhome/data/models/weatherModel.dart';

import '../controllers/WeatherController.dart'; // Import your WeatherController

class WeatherWidget extends StatelessWidget {
  final bool isSwitched;

  WeatherWidget({Key? key, required this.isSwitched, Weatherdata? weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<WeatherHomeController>(
      init: WeatherHomeController(), // Initialize your controller
      builder: (weatherController) {
        Weatherdata? weatherData = weatherController.weatherData.value;
        double tempInCelsius = (weatherData?.main.temp ?? 0) - 273.15; // Convert temperature from Kelvin to Celsius
        double feelsLikeInCelsius = (weatherData?.main.feelsLike ?? 0) - 273.15; // Convert feels like temperature from Kelvin to Celsius
        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              weatherData?.name ?? '', // Use null-aware operators to handle null values
              style: isSwitched ? blacktheme : lighttheme,
            ),
            Text(
              '${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}',
              style: isSwitched ? blacktheme : lighttheme,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 330,
              width: 330,
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/images/welcome.json',
                    width: 180,
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    '${tempInCelsius.toInt()} °C', // Display temperature in Celsius
                    style: isSwitched ? blacktheme : lighttheme,
                  ),
                  Text(
                    'Sunny',
                    style: isSwitched ? blacktheme : lighttheme,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/temp.png"),
                        color: Color(0xff88adf1),
                        size: 50,
                      ),
                      Text(
                        '${feelsLikeInCelsius.toInt()} °C', // Display feels like temperature in Celsius
                        style: isSwitched ? blacktheme : lighttheme,
                      ),
                      Text(
                        'feel like',
                        style: isSwitched ? blacktheme : lighttheme,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/h.png"),
                        color: Color(0xff88adf1),
                        size: 40,
                      ),
                      Text(
                        '${weatherData?.main.humidity ?? 0}%', // Display humidity
                        style: isSwitched ? blacktheme : lighttheme,
                      ),
                      Text(
                        'humidity',
                        style: isSwitched ? blacktheme : lighttheme,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
