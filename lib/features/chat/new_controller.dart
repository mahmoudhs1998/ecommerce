import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';





// class UserChatControlleraaa extends GetxController {
//   var adminIds = <String>[].obs;
//   var selectedAdminId = ''.obs;
//   var chats = <ChatModel>[].obs;
//   var messages = <MessageModel>[].obs;
//   var isLoading = true.obs;
//   var error = ''.obs;
//   var userId = ''.obs;
//
//   final TextEditingController messageController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserId().then((_) => getAdminIds().listen((admins) {
//       adminIds.value = admins;
//       isLoading.value = false;
//     }));
//   }
//
//   Future<void> fetchUserId() async {
//     try {
//       final User? currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) {
//         throw Exception('No user is currently signed in');
//       }
//       userId.value = currentUser.uid;
//     } catch (e) {
//       error.value = 'Failed to fetch user ID: $e';
//       print('Error in fetchUserId: ${error.value}');
//     }
//   }
//
//   Future<void> sendMessage(String messageText) async {
//     if (messageText.isEmpty || selectedAdminId.value.isEmpty) {
//       print('Validation failed: messageText or selectedAdminId is empty.');
//       return;
//     }
//
//     isLoading.value = true;
//     error.value = '';
//
//     try {
//       final userChatsRef = FirebaseFirestore.instance
//           .collection('Users')
//           .doc(userId.value)
//           .collection('Chats');
//
//       final chatSnapshot = await userChatsRef
//           .where('adminId', isEqualTo: selectedAdminId.value)
//           .limit(1)
//           .get();
//
//       DocumentReference chatRef;
//
//       if (chatSnapshot.docs.isNotEmpty) {
//         chatRef = chatSnapshot.docs.first.reference;
//       } else {
//         chatRef = userChatsRef.doc();
//         await chatRef.set({
//           'adminId': selectedAdminId.value,
//           'lastMessage': messageText,
//           'lastMessageTimestamp': FieldValue.serverTimestamp(),
//         });
//         print('New chat document created in Users -> Chats: ${chatRef.id}');
//       }
//
//       final messageRef = chatRef.collection('Messages').doc();
//
//       await messageRef.set({
//         'senderId': userId.value,
//         'messageText': messageText,
//         'timestamp': FieldValue.serverTimestamp(),
//         'isRead': false,
//       });
//
//       print('Message successfully set in Users -> Chats -> Messages.');
//
//       await chatRef.update({
//         'lastMessage': messageText,
//         'lastMessageTimestamp': FieldValue.serverTimestamp(),
//       });
//
//       print('Chat document updated in Users -> Chats.');
//
//       messageController.clear();
//     } catch (e) {
//       error.value = 'Failed to send message: $e';
//       print('Error in sendMessage: ${error.value}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Stream<List<String>> getAdminIds() {
//     return FirebaseFirestore.instance.collection('Admins').snapshots().map((adminsSnapshot) {
//       return adminsSnapshot.docs.map((doc) => doc.id).toList();
//     }).handleError((error) {
//       print('Error fetching admin IDs: $error');
//       throw error;
//     });
//   }
//
//   Stream<List<ChatModel>> getChatsForAdmin(String adminId) {
//     if (adminId.isEmpty) return Stream.value([]);
//
//     return FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userId.value)
//         .collection('Chats')
//         .where('adminId', isEqualTo: adminId)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return ChatModel(
//           chatId: doc.id,
//           lastMessage: doc['lastMessage'] ?? '',
//           lastMessageTimestamp: doc['lastMessageTimestamp']?.toDate() ?? DateTime.now(),
//         );
//       }).toList();
//     });
//   }
//
//   Stream<List<MessageModel>> getMessagesForChat(String chatId) {
//     if (chatId.isEmpty) return Stream.value([]);
//
//     return FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userId.value)
//         .collection('Chats')
//         .doc(chatId)
//         .collection('Messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => MessageModel.fromFirestore(doc)).toList();
//     });
//   }
// }


class UserChatControlleraaa extends GetxController {
  var adminIds = <String>[].obs;
  var selectedAdminId = ''.obs;
  var chats = <ChatModel>[].obs;
  var messages = <MessageModel>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;
  var userId = ''.obs;

  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserId().then((_) {
      getAdminIds().listen((admins) {
        adminIds.value = admins;
        isLoading.value = false;
      });
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
    if (messageText.isEmpty || selectedAdminId.value.isEmpty) {
      print('Validation failed: messageText or selectedAdminId is empty.');
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
          .where('adminId', isEqualTo: selectedAdminId.value)
          .limit(1)
          .get();

      DocumentReference chatRef;

      if (chatSnapshot.docs.isNotEmpty) {
        chatRef = chatSnapshot.docs.first.reference;
      } else {
        chatRef = userChatsRef.doc();
        await chatRef.set({
          'adminId': selectedAdminId.value,
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

  Stream<List<String>> getAdminIds() {
    return FirebaseFirestore.instance.collection('Admins').snapshots().map((adminsSnapshot) {
      return adminsSnapshot.docs.map((doc) => doc.id).toList();
    }).handleError((error) {
      print('Error fetching admin IDs: $error');
      throw error;
    });
  }

  Stream<List<ChatModel>> getChatsForAdmin(String adminId) {
    if (adminId.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId.value)
        .collection('Chats')
        .where('adminId', isEqualTo: adminId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatModel(
          chatId: doc.id,
          lastMessage: doc['lastMessage'] ?? '',
          lastMessageTimestamp: doc['lastMessageTimestamp']?.toDate() ?? DateTime.now(),
        );
      }).toList();
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
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel(
          messageId: doc.id,
          senderId: doc['senderId'] ?? 'Unknown sender',
          messageText: doc['messageText'] ?? 'No text',
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
