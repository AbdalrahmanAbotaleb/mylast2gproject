import 'package:get/get.dart';
import '../../../../core/services/NetworkData.dart';
import '../../data/models/plant.dart';
import '../../domain/repositories/fetch_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class PlantController extends GetxController {
  var plants = <Plant>[].obs;
  var searchQuery = ''.obs;
  var isConnected = true.obs;
  final NetworkInfo _networkInfo;

  PlantController(this._networkInfo);

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  void checkConnectivity() async {
    isConnected.value = await _networkInfo.isConnected;

    _networkInfo.onConnectivityChanged.listen((ConnectivityResult result) {
      bool wasConnected = isConnected.value;
      isConnected.value = result != ConnectivityResult.none;

      if (wasConnected && !isConnected.value) {
        Get.snackbar('No Internet', 'Please check your internet connection');
      } else if (!wasConnected && isConnected.value) {
        fetchPlants();
      }
    });
  }

  void fetchPlants() async {
    if (!isConnected.value) {
      Get.snackbar('No Internet', 'Please check your internet connection');
      return;
    }
    try {
      var fetchedPlants = await fetchPlantsFromApi();
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
      .where((plant) =>
          plant.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  List<Plant> get vegetables => plants
      .where((plant) => plant.plantCategory == 'Vegetables')
      .toList();
  List<Plant> get fruits =>
      plants.where((plant) => plant.plantCategory == 'Fruits').toList();
}
