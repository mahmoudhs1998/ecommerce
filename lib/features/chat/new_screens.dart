import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models.dart';
import 'new_controller.dart';

class UserChatScreensss extends StatelessWidget {
  final UserChatControllersss controller = Get.put(UserChatControllersss());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Chat'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        }

        return Row(
          children: [
            Expanded(
              flex: 2,
              child: ChatsList(controller: controller),
            ),
            Expanded(
              flex: 3,
              child: ChatWindow(controller: controller),
            ),
          ],
        );
      }),
    );
  }
}

class ChatsList extends StatelessWidget {
  final UserChatControllersss controller;

  ChatsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    ChatModel ? chatModel;
    return StreamBuilder<List<ChatModel>>(
      stream: controller.getChats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final chats = snapshot.data ?? [];
        print('ChatsList: ${chats.length} chats found'); // Debugging line
        if (chats.isEmpty) {
          return Center(child: Text('No chats available.'));
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              title: Text('Chat with ${chat.chatId}'),
              subtitle: Text(chat.lastMessage!),
              onTap: () {
                controller.selectedChatId.value = chat.chatId;
              },
            );
          },
        );
      },
    );
  }
}

class ChatWindow extends StatelessWidget {
  final UserChatControllersss controller;

  ChatWindow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedChatId.value.isEmpty) {
        return Center(child: Text('Select a chat to view messages.'));
      }

      return StreamBuilder<List<MessageModel>>(
        stream: controller.getMessagesForChat(controller.selectedChatId.value),
        builder: (context, messageSnapshot) {
          if (messageSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (messageSnapshot.hasError) {
            return Center(child: Text('Error: ${messageSnapshot.error}'));
          }

          final messages = messageSnapshot.data ?? [];
          if (messages.isEmpty) {
            return Center(child: Text('No messages yet.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message.messageText),
                      subtitle: Text('${message.senderId} - ${message.timestamp}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final messageText = controller.messageController.text.trim();
                        if (messageText.isNotEmpty) {
                          controller.sendMessage(messageText);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
