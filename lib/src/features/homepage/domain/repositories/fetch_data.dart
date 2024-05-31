import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/plant.dart';

Future<List<Plant>> fetchPlantsFromApi() async {
  final response = await http.get(Uri.parse('https://plantdiseasexapi.runasp.net/api/Plants'));

  if (response.statusCode == 200) {
    print(response.body);
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((plant) => Plant.fromJson(plant)).toList();
  } else {
    throw Exception('Failed to load plants');
  }
}

Future<Plant> fetchPlantDetails(int id) async {
  final response = await http.get(Uri.parse('https://plantdiseasexapi.runasp.net/api/Plants/$id'));

  if (response.statusCode == 200) {
    return Plant.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load plant details');
  }
}
