import 'package:get/get.dart';
import '../../../../core/services/NetworkData.dart';
import '../../data/models/plant.dart';
import '../../domain/repositories/fetch_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class PlantController extends GetxController {
  var plants = <Plant>[].obs;
  var searchQuery = ''.obs;
  var isConnected = true.obs;
  final NetworkInfo _networkInfo; // Inject NetworkInfo dependency

  PlantController(this._networkInfo); // Constructor to inject NetworkInfo

  @override
  void onInit() {
    super.onInit();
    checkConnectivity(); // Start listening for connectivity changes
  }

  void checkConnectivity() async {
    isConnected.value = await _networkInfo.isConnected; // Check initial connectivity status

    _networkInfo.onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        fetchPlants(); // If connected, fetch plants automatically
      }
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
