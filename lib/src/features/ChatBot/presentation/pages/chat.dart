import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatPage extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: chatController.clearChat,
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(
            () => Container(
              height: MediaQuery.of(context).size.height - 160,
              child: ListView.builder(
                itemCount: chatController.chatHistory.length,
                shrinkWrap: false,
                controller: chatController.scrollController,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final message = chatController.chatHistory[index];
                  final isSender = message["isSender"];
                  final messageContent = message["message"];
                  final timestamp = DateTime.parse(message["time"]);

                  return Column(
                    crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: isSender ? Color.fromARGB(255, 27, 207, 252) : Color.fromARGB(255, 66, 174, 247),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: message["isImage"]
                                ? Image.file(
                                    File(messageContent),
                                    width: 200,
                                  )
                                : Text(
                                    messageContent,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: isSender ? Color.fromARGB(255, 211, 250, 211) : Color.fromARGB(255, 231, 238, 234),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14, top: 4,),
                        child: Text(
                          "${timestamp.hour}:${timestamp.minute}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 29, 141, 156),
                            Color.fromARGB(255, 113, 207, 223),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          controller: chatController.chatController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  MaterialButton(
                    onPressed: () {
                      chatController.sendMessage();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 17, 161, 218),
                            Color.fromARGB(255, 67, 212, 223),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.send,size: 30, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
