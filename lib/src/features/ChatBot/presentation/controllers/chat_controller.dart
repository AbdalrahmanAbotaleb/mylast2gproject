import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ChatController extends GetxController {
  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;
  late final ChatSession _chat;

  final TextEditingController chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxList<Map<String, dynamic>> chatHistory = <Map<String, dynamic>>[].obs;
  RxString? file = ''.obs;
  var isOffline = false.obs;

  @override
  void onInit() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'AIzaSyBhkx7a--6fSGiLDl0JN1A_PAg8Hg371hY',
    );
    _visionModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: 'AIzaSyBhkx7a--6fSGiLDl0JN1A_PAg8Hg371hY',
    );
    _chat = _model.startChat();
    _loadChatHistory();
    _initConnectivity();
    super.onInit();
  }

  void sendMessage() async {
    if (chatController.text.isNotEmpty) {
      String userQuestion = chatController.text;
      Map<String, dynamic> userQuestionData = {
        "time": DateTime.now().toIso8601String(),
        "message": userQuestion,
        "isSender": true,
        "isImage": false,
      };
      chatController.clear();

      _addMessageToChatHistory(userQuestionData);

      var response = await getAnswer(userQuestion);

      Map<String, dynamic> modelResponseData = {
        "time": DateTime.now().toIso8601String(),
        "message": response.text,
        "isSender": false,
        "isImage": false,
      };

      _addMessageToChatHistory(modelResponseData);

      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }
  }

  Future<dynamic> getAnswer(String text) async {
    if (file?.value != null && file!.value.isNotEmpty) {
      final firstImage = await File(file!.value!).readAsBytes();
      final prompt = TextPart(text);
      final imageParts = [
        DataPart('image/jpeg', firstImage),
      ];
      var response = await _visionModel.generateContent([
        Content.multi([
          prompt,
        ])
      ]);
      file?.value = '';
      return response;
    } else {
      var content = Content.text(text.toString());
      var response = await _chat.sendMessage(content);
      return response;
    }
  }

  void _initConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    _updateConnectionStatus(connectivityResult);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        isOffline.value = false;
        break;
      case ConnectivityResult.none:
        isOffline.value = true;
        _showNetworkDialog();
        break;
      default:
        isOffline.value = true;
        break;
    }
  }

  void _showNetworkDialog() {
    Get.defaultDialog(
      title: "No Internet Connection",
      content: Text("Please check your internet connection."),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("OK"),
        ),
      ],
    );
  }

  void _loadChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chatHistoryString = prefs.getString('chat_history');
    if (chatHistoryString != null) {
      chatHistory.value =
          List<Map<String, dynamic>>.from(jsonDecode(chatHistoryString));
    }
  }

  void _saveChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_history', jsonEncode(chatHistory));
  }

  void _addMessageToChatHistory(Map<String, dynamic> message) {
    chatHistory.add(message);
    _saveChatHistory();
  }

  void clearChat() {
    chatHistory.clear();
    _saveChatHistory();
  }

  @override
  void onClose() {
    chatController.dispose();
    super.onClose();
  }
}