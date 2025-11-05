import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatBotController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initial message from the bot
    messages.add(
      ChatMessage(text: "Hello! How can I assist you today?", isUser: false),
    );
  }

  void sendMessage() {
    final text = textController.text;
    if (text.isEmpty) return;

    // Add user message
    messages.add(ChatMessage(text: text, isUser: true));

    // Clear the input field
    textController.clear();

    // Simulate a bot response
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(
        ChatMessage(text: "I am currently under development. Please check back later!", isUser: false),
      );
    });
  }
}
