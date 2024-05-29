import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/plant_controller.dart';
import 'plant_grid_view.dart';

class PlantHomePage extends StatelessWidget {
  final PlantController plantController = Get.put(PlantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/images/46-notification.gif'),
                  size: 40,
                ),
                onPressed: () {}),
            IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/images/63-settings.gif'),
                  size: 40,
                ),
                onPressed: () {}),
          ],
          elevation: 0,
          title: Image.asset(
            "assets/images/glogo.png",
          )),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Help Us To Save Our Mother Earth",
                  style: TextStyle(
                    color: Color(0xff394929),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                plantController.updateSearchQuery(query);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (plantController.plants.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffE6FFD6),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: const Color(0xffF2F6EE)),
                          labelColor: const Color.fromARGB(255, 10, 10, 10),
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            CustomTab(text: 'Plants'),
                            CustomTab(text: 'Vegetable'),
                            CustomTab(text: 'Fruits'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            plantController.fetchPlants();
                          },
                          child: TabBarView(
                            children: [
                              PlantGridView(
                                  plants: plantController.filteredPlants),
                              PlantGridView(
                                  plants: plantController.vegetables
                                      .where((plant) => plant.name
                                          .toLowerCase()
                                          .contains(plantController
                                              .searchQuery.value
                                              .toLowerCase()))
                                      .toList()),
                              PlantGridView(
                                  plants: plantController.fruits
                                      .where((plant) => plant.name
                                          .toLowerCase()
                                          .contains(plantController
                                              .searchQuery.value
                                              .toLowerCase()))
                                      .toList()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 150,)
                    ],
                    
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String text;

  CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
