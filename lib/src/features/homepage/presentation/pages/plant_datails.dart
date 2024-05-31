import 'package:flutter/material.dart';
import 'package:mylast2gproject/src/features/homepage/data/models/plant.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  PlantDetailPage({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(plant.pictureUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // يمكنك إضافة عناصر إضافية هنا، مثل النصوص أو الأزرار
              
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 223, 255, 252),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(31, 10, 10, 10),
                      blurRadius: 0,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details Of ${plant.name} Plant',
                      style: const TextStyle(
                        color: Color(0xFF3E8005),
                        fontSize: 17,
                        fontFamily: 'Rammetto One',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.description,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Diseases',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.diseases,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Treatment',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.treatment,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Plant Season',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.plantSeason,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'General Use',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.generalUse,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Medical Use',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.medicalUse,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Properties',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.properties,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Warnings',
                      style: TextStyle(
                        color: Color(0xFF3F8105),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      plant.warnings,
                      style: const TextStyle(
                        color: Color(0xB257793A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
