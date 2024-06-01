import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shimmer/shimmer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DiagnosisDetailsPage extends StatefulWidget {
  final File image;
  final String disease;

  const DiagnosisDetailsPage({
    required this.image,
    required this.disease,
  });

  @override
  _DiagnosisDetailsPageState createState() => _DiagnosisDetailsPageState();
}

class _DiagnosisDetailsPageState extends State<DiagnosisDetailsPage> {
  late final GenerativeModel _model;
  String? diseaseExplanation;
  bool isLoading = true;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'AIzaSyBhkx7a--6fSGiLDl0JN1A_PAg8Hg371hY',
    );
    fetchDiseaseExplanation(widget.disease);
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOffline = true;
      });
    } else {
      setState(() {
        isOffline = false;
      });
    }
  }

  Future<void> fetchDiseaseExplanation(String disease) async {
    try {
      final response = await _model.generateContent([
        Content.text(disease),
      ]);
      setState(() {
        diseaseExplanation = response.text;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await fetchDiseaseExplanation(widget.disease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases Details'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200.0,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 20.0,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 16.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.file(widget.image),
                        const SizedBox(height: 20),
                        Text(
                          'Disease: ${widget.disease}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        isOffline
                            ? Text(
                                'No internet connection',
                                style: const TextStyle(fontSize: 16),
                              )
                            : diseaseExplanation != null
                                ? Text(
                                    'Explanation: $diseaseExplanation',
                                    style: const TextStyle(fontSize: 16),
                                  )
                                : const Text(
                                    'Explanation not available',
                                    style: TextStyle(fontSize: 16),
                                  ),

                        SizedBox(height: 40,)
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
