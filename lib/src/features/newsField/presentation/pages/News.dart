import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../core/services/NetworkData.dart';
import '../controllers/news_controller.dart';
import '../widgets/NewsBody.dart';

class NewsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsController = Get.put(NewsController(networkInfo: NetworkInfoImpl(Connectivity())));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Articles',
          style: GoogleFonts.aclonica(),
        ),
      ),
      body: Obx(() {
        if (newsController.isLoading.value) {
          return _buildShimmerListView();
        } else if (newsController.isOffline.value && newsController.showOfflineMessage.value) {
          return Center(child: Text('No internet connection.'));
        } else if (newsController.newsList.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return RefreshIndicator(
            onRefresh: newsController.refreshData,
            child: ListView.builder(
              itemCount: newsController.newsList.length,
              itemBuilder: (context, index) {
                final article = newsController.newsList[index];
                return NewsBody(article: article);
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildShimmerListView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 16,
                  width: 200,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 16,
                  width: 150,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 100,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
