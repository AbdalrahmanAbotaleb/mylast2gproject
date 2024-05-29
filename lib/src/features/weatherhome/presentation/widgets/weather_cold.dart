import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mylast2gproject/src/core/constants/weatherConst.dart';
import 'package:mylast2gproject/src/features/weatherhome/data/models/weatherModel.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/controllers/WeatherController.dart';

class WeatherWidgetCold extends StatelessWidget {
  final Weatherdata? weatherData;
  final bool isSwitched;

  WeatherWidgetCold({Key? key, required this.weatherData, required this.isSwitched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherHomeController>(
      builder: (controller) {
        double tempInCelsius = (weatherData!.main.temp - 273.15); // Convert temperature from Kelvin to Celsius
        double feelsLikeInCelsius = (weatherData!.main.feelsLike - 273.15); // Convert feels like temperature from Kelvin to Celsius

        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              weatherData!.name,
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
                    'assets/images/cloud.json',
                    width: 220,
                    height: 220,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    '${tempInCelsius.toInt()}°C', // Display temperature in Celsius
                    style: isSwitched ? blacktheme : lighttheme,
                  ),
                  Text(
                    'Cold',
                    style: isSwitched ? blacktheme : lighttheme,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
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
                        '${feelsLikeInCelsius.toInt()}°C', // Display feels like temperature in Celsius
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
                        '${weatherData!.main.humidity}%',
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
