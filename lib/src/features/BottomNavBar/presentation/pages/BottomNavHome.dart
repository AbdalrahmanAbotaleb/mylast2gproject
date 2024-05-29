import 'package:flutter/material.dart';
import 'package:mylast2gproject/src/features/ChatBot/presentation/pages/BotHome.dart';
import 'package:mylast2gproject/src/features/ScanningHome/presentation/pages/home.dart';
import 'package:mylast2gproject/src/features/weatherhome/presentation/pages/welcome.dart';
// import 'package:mylastgproject/src/features/WeatherHome/presentation/widgets/Weather.dart';

import '../../../homepage/presentation/pages/plant_home_page.dart';
import '../../../newsField/presentation/pages/News.dart';

class BottomNavBarV2 extends StatefulWidget {
  const BottomNavBarV2({super.key});

  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Define your list of pages here
  List<Widget> pages = [
    PlantHomePage(),
    NewsField(),
   ScanPage(),
    const MainScreen(),
    const HomeBot()
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          // Show the current page based on currentIndex
          pages[currentIndex],
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50), // Adjust as needed
                          // side: BorderSide(
                          //     color: Colors.blue,
                          //     width: 5), // Border color and width
                        ),
                        backgroundColor: Color.fromARGB(255, 110, 247, 117),
                        foregroundColor: currentIndex == 2
                            ? const Color.fromARGB(255, 46, 155, 79)
                            : Colors.grey.shade400,
                        child: const Icon(
                          Icons.flip,
                          size: 30,
                        ),
                        elevation: 0.1,
                        onPressed: () {
                          setBottomBarIndex(2);
                        }),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            size: 30,
                            color: currentIndex == 0
                                ? const Color.fromARGB(255, 11, 255, 64)
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.feed,
                              size: 30,
                              color: currentIndex == 1
                                  ? const Color.fromARGB(255, 11, 255, 64)
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(1);
                            }),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.thermostat,
                              size: 30,
                              color: currentIndex == 3
                                  ? const Color.fromARGB(255, 11, 255, 64)
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(3);
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.smart_toy,
                              size: 30,
                              color: currentIndex == 4
                                  ? const Color.fromARGB(255, 11, 255, 64)
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(4);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromARGB(255, 22, 194, 142)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}





