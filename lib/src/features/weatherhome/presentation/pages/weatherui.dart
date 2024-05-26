import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mylast2gproject/src/core/constants/weatherConst.dart';
import 'package:mylast2gproject/src/features/weatherhome/data/models/weatherModel.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/widgets/weather_cold.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/widgets/weather_hot.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final citycontroller = TextEditingController();
  bool isloading = false;
  Weatherdata? weatherdata;
  bool isswitched = false;

  @override
  void initState() {
    super.initState();
    loadSavedState();
  }

  void loadSavedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      citycontroller.text = prefs.getString('city') ?? 'cairo';
      isswitched = prefs.getBool('switchState') ?? false;
    });
    getData();
  }

  void saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', citycontroller.text);
    prefs.setBool('switchState', isswitched);
  }

  Future<void> getData() async {
    setState(() {
      isloading = true;
    });
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${citycontroller.text}&appid=509dc5d730ff2dd6003b22f30ae93313'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData != null) {
          setState(() {
            weatherdata = Weatherdata.fromJson(jsonData);
            isloading = false;
          });
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
    if (weatherdata != null) {
      double temperature = weatherdata!.main.temp;
      if (temperature > 30) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('تنبيه!'),
              content: Text('درجة الحرارة مرتفعة جداً، يرجى اتخاذ الاحتياطات اللازمة.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('حسنًا'),
                ),
              ],
            );
          },
        );
      } else if (temperature < 10) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('تنبيه!'),
              content: Text('درجة الحرارة منخفضة جداً، المحاصيل قد تكون معرضة للتلف.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('حسنًا'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isswitched ? Color(0xff090a0a) : Color(0xffeaedf1),
        elevation: 0.0,
        title: Text(
          'Weather App',
          style: isswitched ? blacktheme : lighttheme,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                color: isswitched ? Colors.white : Colors.black,
                onPressed: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          title: Text('Search By City Name'),
                          content: TextField(
                            onChanged: (value) {},
                            controller: citycontroller,
                            decoration:
                                InputDecoration(hintText: "City name : "),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  saveState();
                                  getData();
                                  Navigator.pop(
                                      context, citycontroller.text);
                                });
                              },
                              child: Text('Search'),
                            )
                          ],
                        );
                      },
                    );
                  });
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              Switch(
                value: isswitched,
                onChanged: (value) {
                  setState(() {
                    isswitched = value;
                    saveState();
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: MediaQuery.of(context).size.height,
          color: isswitched ? Color(0xff090a0a) : Color(0xffeaedf1),
          child: Column(
            children: [
              isloading
                  ? Center(
                      child: const CircularProgressIndicator(),
                    )
                  : weatherdata != null
                      ? Column(
                          children: [
                            weatherdata!.main.temp > 292
                                ? weatherwidget(
                                    weatherdata1: weatherdata,
                                    isswitched: isswitched,
                                  )
                                : weather_widget_cold(
                                    weatherdata2: weatherdata,
                                    isswitched2: isswitched,
                                  )
                          ],
                        )
                      : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
