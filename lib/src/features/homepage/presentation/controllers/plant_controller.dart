import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../../data/models/plant.dart';
import '../../domain/repositories/fetch_data.dart';

class PlantController extends GetxController {
  var plants = <Plant>[].obs;
  var searchQuery = ''.obs;
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlants();
    checkConnectivity();
  }

  void checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
    });
  }

  void fetchPlants() async {
    if (!isConnected.value) {
      Get.snackbar('No Internet', 'Please check your internet connection');
      return;
    }
    try {
      var fetchedPlants = await fetchPlantsFromApi(); // Use the renamed function
      if (fetchedPlants != null) {
        plants.assignAll(fetchedPlants);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<Plant> get filteredPlants => plants
      .where((plant) => plant.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  List<Plant> get vegetables => plants.where((plant) => plant.plantCategory == 'Vegetables').toList();
  List<Plant> get fruits => plants.where((plant) => plant.plantCategory == 'Fruits').toList();
}
