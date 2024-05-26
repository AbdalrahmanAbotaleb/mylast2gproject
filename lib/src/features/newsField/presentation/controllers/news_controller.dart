import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mylast2gproject/src/core/services/NetworkData.dart';
import '../../../newsField/data/models/NewsModel.dart';

class NewsController extends GetxController {
  var newsList = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var isOffline = false.obs;
  var showOfflineMessage = false.obs;

  final NetworkInfo networkInfo;

  NewsController({required this.networkInfo});

  @override
  void onInit() {
    super.onInit();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    isLoading.value = true;
    isOffline.value = !(await networkInfo.isConnected);

    if (!isOffline.value) {
      try {
        final url = Uri.parse('http://plantdiseasexapi.runasp.net/api/NewsArticle');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List<dynamic> responseData = json.decode(response.body)['data'];
          List<NewsArticle> newsArticles = responseData.map((json) => NewsArticle.fromJson(json)).toList();

          newsArticles.sort((a, b) => b.date.compareTo(a.date));
          newsList.assignAll(newsArticles);
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        print('Error fetching news data: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      showOfflineMessageAfterDelay();
      isLoading.value = false;
    }
  }

  Future<void> showOfflineMessageAfterDelay() async {
    // Show the offline message after a delay
    await Future.delayed(const Duration(seconds: 2));
    showOfflineMessage.value = true;
  }

  Future<void> refreshData() async {
    await fetchNewsData();
  }
}
