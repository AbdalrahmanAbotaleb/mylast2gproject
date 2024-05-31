import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'plant_datails.dart';
import '../../data/models/plant.dart';

class PlantGridView extends StatelessWidget {
  final List<Plant> plants;

  PlantGridView({required this.plants});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => PlantDetailPage(plant: plant));
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(plant.pictureUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff569033),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const ImageIcon(
                            AssetImage('assets/images/55-arrow-right-2.png'),
                            size: 25,
                          ),
                          onPressed: () {
                            Get.to(() => PlantDetailPage(plant: plant));
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          plant.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
