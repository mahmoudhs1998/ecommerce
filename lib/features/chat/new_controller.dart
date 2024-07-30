import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

class UserChatControllersss extends GetxController {
  var chats = <ChatModel>[].obs;
  var messages = <MessageModel>[].obs;
  var selectedChatId = ''.obs;
  var isLoading = true.obs;
  var error = ''.obs;
  var userId = ''.obs;

  final TextEditingController messageController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchUserId().then((_) {
      getChats().listen((chats) {
        this.chats.value = chats;
        isLoading.value = false;
      });
    });
    fetchChats();
  }
  void fetchChats() {
    final userId = currentUser!.uid; // Replace with actual user ID logic
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Chats')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatModel.fromDocument(doc);
      }).toList();
    }).listen((chatList) {
      chats.value = chatList;
    }).onError((error) {
      print('Error fetching chats: $error');
    });
  }
  Future<void> fetchUserId() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in');
      }
      userId.value = currentUser.uid;
    } catch (e) {
      error.value = 'Failed to fetch user ID: $e';
      print('Error in fetchUserId: ${error.value}');
    }
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.isEmpty || selectedChatId.value.isEmpty) {
      print('Validation failed: messageText or selectedChatId is empty.');
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final userChatsRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId.value)
          .collection('Chats');

      final chatSnapshot = await userChatsRef
          .where('chatId', isEqualTo: selectedChatId.value)
          .limit(1)
          .get();

      DocumentReference chatRef;

      if (chatSnapshot.docs.isNotEmpty) {
        chatRef = chatSnapshot.docs.first.reference;
      } else {
        chatRef = userChatsRef.doc();
        await chatRef.set({
          'chatId': selectedChatId.value,
          'lastMessage': messageText,
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
        });
        print('New chat document created in Users -> Chats: ${chatRef.id}');
      }

      final messageRef = chatRef.collection('Messages').doc();

      await messageRef.set({
        'senderId': userId.value,
        'messageText': messageText,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });

      print('Message successfully set in Users -> Chats -> Messages.');

      await chatRef.update({
        'lastMessage': messageText,
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      });

      print('Chat document updated in Users -> Chats.');

      messageController.clear();
    } catch (e) {
      error.value = 'Failed to send message: $e';
      print('Error in sendMessage: ${error.value}');
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<ChatModel>> getChats() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId.value)
        .collection('Chats')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        final chatId = data['chatId'] ?? '';
        final lastMessage = data['lastMessage'] ?? '';
        final lastMessageTimestamp = data['lastMessageTimestamp']?.toDate() ?? DateTime.now();

        // Log and handle missing fields
        if (chatId.isEmpty) {
          print('Warning: Document ${doc.id} is missing chatId.');
        }

        return ChatModel(
          chatId: chatId,
          lastMessage: lastMessage,
          lastMessageTimestamp: lastMessageTimestamp,
        );
      }).toList();
    }).handleError((error) {
      print('Error fetching chats: $error');
      throw error;
    });
  }

  Stream<List<MessageModel>> getMessagesForChat(String chatId) {
    if (chatId.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId.value)
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      print('Fetched ${snapshot.docs.length} messages');
      return snapshot.docs.map((doc) {
        return MessageModel(
          messageId: doc.id,
          senderId: doc['senderId'],
          messageText: doc['messageText'],
          timestamp: doc['timestamp']?.toDate() ?? DateTime.now(),
          isRead: doc['isRead'] ?? false,
        );
      }).toList();
    }).handleError((error) {
      print('Error fetching messages: $error');
      throw error;
    });
  }
}
