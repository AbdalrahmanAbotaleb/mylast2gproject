import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mylast2gproject/src/core/services/NetworkData.dart';
import 'package:mylast2gproject/src/features/newsField/data/models/NewsModel.dart';

class NewsController extends GetxController {
  var newsList = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var isOffline = false.obs;
  var showOfflineMessage = false.obs; // Expose this variable
  late final NetworkInfo _networkInfo;

  NewsController({required NetworkInfo networkInfo}) : _networkInfo = networkInfo;

  @override
  void onInit() {
    fetchNewsData();
    _initConnectivity();
    super.onInit();
  }

  void _initConnectivity() async {
    _networkInfo.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
    isOffline.value = !(await _networkInfo.isConnected);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isOffline.value = result == ConnectivityResult.none;
    if (isOffline.value) {
      if (isLoading.value) {
        showOfflineMessage.value = true;
      }
    } else {
      showOfflineMessage.value = false;
    }
  }

  Future<void> fetchNewsData() async {
    isLoading.value = true;
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
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchNewsData();
  }
}
