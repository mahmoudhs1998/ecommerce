import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/repositories/authentication/authentication_repository.dart';
import 'models.dart';





// class UserChatController extends GetxController {
//   var currentChatId = ''.obs;
//   var currentUserId = ''.obs;
//   var messages = <MessageModel>[].obs;
//   var isTyping = false.obs;
//   var isLoading = true.obs;
//   var error = ''.obs;
//
//   final TextEditingController messageController = TextEditingController();
//   final AuthenticationRepository _authRepo = AuthenticationRepository.instance;
//
//   @override
//   void onInit() {
//     super.onInit();
//     ever(currentChatId, (_) => fetchMessages());
//     initializeUserId();
//   }
//   var isInitialized = false.obs;
//   void initializeUserId() async {
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       // Get the current user from the AuthenticationRepository
//       User? currentUser = _authRepo.currentAuthUser;
//
//       if (currentUser == null) {
//         throw Exception('User is not authenticated');
//       }
//
//       currentUserId.value = currentUser.uid;
//
//       if (currentUserId.value.isEmpty) {
//         throw Exception('User ID is empty');
//       }
//
//       final userDoc = FirebaseFirestore.instance.collection('Users').doc(currentUserId.value);
//
//       // Check if there's an existing chat
//       final existingChats = await userDoc.collection('Chats').limit(1).get();
//
//       if (existingChats.docs.isNotEmpty) {
//         // Use the first existing chat
//         currentChatId.value = existingChats.docs.first.id;
//       } else {
//         // Create a new chat
//         currentChatId.value = Uuid().v4();
//         await sendInitialMessage();
//       }
//
//       isLoading.value = false;
//     } catch (e) {
//       error.value = 'Failed to initialize user ID: $e';
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> sendInitialMessage() async {
//     try {
//       await sendMessage("Chat started");
//     } catch (e) {
//       error.value = 'Failed to send initial message: $e';
//     }
//   }
//
//
//   Future<void> fetchMessages() async {
//     if (currentChatId.value.isEmpty) {
//       isLoading.value = false;
//       return;
//     }
//
//     isLoading.value = true;
//     error.value = '';
//
//     try {
//       FirebaseFirestore.instance
//           .collection('Users')
//           .doc(currentUserId.value)
//           .collection('Chats')
//           .doc(currentChatId.value)
//           .collection('Messages')
//           .orderBy('timestamp')
//           .snapshots()
//           .listen((snapshot) {
//         messages.value = snapshot.docs.map((doc) {
//           return MessageModel(
//             messageId: doc.id,
//             senderId: doc['senderId'],
//             messageText: doc['messageText'],
//             timestamp: doc['timestamp'].toDate(),
//             isRead: doc['isRead'],
//           );
//         }).toList();
//         isLoading.value = false;
//       }, onError: (e) {
//         error.value = 'Failed to fetch messages: $e';
//         isLoading.value = false;
//       });
//     } catch (e) {
//       error.value = 'Failed to set up message listener: $e';
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> sendMessage(String messageText) async {
//     if (messageText.isEmpty || currentUserId.value.isEmpty) {
//       error.value = 'Message text or User ID cannot be empty';
//       return;
//     }
//
//     try {
//       if (currentChatId.value.isEmpty) {
//         currentChatId.value = Uuid().v4();
//       }
//
//       final userDoc = FirebaseFirestore.instance.collection('Users').doc(currentUserId.value);
//       final chatRef = userDoc.collection('Chats').doc(currentChatId.value);
//       final messagesRef = chatRef.collection('Messages');
//
//       final docSnapshot = await chatRef.get();
//       if (!docSnapshot.exists) {
//         await chatRef.set({
//           'createdAt': Timestamp.now(),
//           'updatedAt': Timestamp.now(),
//           'lastMessage': '',
//           'lastMessageTimestamp': Timestamp.now(),
//           'participants': [currentUserId.value],
//         });
//       }
//
//       await messagesRef.add({
//         'senderId': currentUserId.value,
//         'messageText': messageText,
//         'timestamp': Timestamp.now(),
//         'isRead': false,
//       });
//
//       await chatRef.update({
//         'lastMessage': messageText,
//         'lastMessageTimestamp': Timestamp.now(),
//         'updatedAt': Timestamp.now(),
//       });
//
//       messageController.clear();
//       updateTypingStatus(false);
//     } catch (e) {
//       error.value = 'Failed to send message: $e';
//     }
//   }
//
//   void updateTypingStatus(bool isTyping) {
//     if (currentChatId.value.isEmpty || currentUserId.value.isEmpty) {
//       error.value = 'Chat ID or User ID cannot be empty';
//       return;
//     }
//
//     try {
//       FirebaseFirestore.instance
//           .collection('Users')
//           .doc(currentUserId.value)
//           .collection('Chats')
//           .doc(currentChatId.value)
//           .update({'typing': isTyping ? currentUserId.value : ''});
//       this.isTyping.value = isTyping;
//     } catch (e) {
//       error.value = 'Failed to update typing status: $e';
//     }
//   }
// }


// class UserChatController extends GetxController {
//   var currentChatId = ''.obs;
//   var currentUserId = ''.obs;
//   var messages = <MessageModel>[].obs;
//   var isTyping = false.obs;
//   var isLoading = true.obs;
//   var error = ''.obs;
//
//   final TextEditingController messageController = TextEditingController();
//   final AuthenticationRepository _authRepo = AuthenticationRepository.instance;
//
//   @override
//   void onInit() {
//     super.onInit();
//     ever(currentChatId, (_) => fetchMessages());
//     initializeUserId();
//   }
//
//   Future<void> initializeUserId() async {
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       User? currentUser = _authRepo.currentAuthUser;
//
//       if (currentUser == null) {
//         throw Exception('User is not authenticated');
//       }
//
//       currentUserId.value = currentUser.uid;
//
//       final userDoc = FirebaseFirestore.instance.collection('Users').doc(currentUserId.value);
//
//       final existingChats = await userDoc.collection('Chats').limit(1).get();
//
//       if (existingChats.docs.isNotEmpty) {
//         currentChatId.value = existingChats.docs.first.id;
//       } else {
//         currentChatId.value = Uuid().v4();
//         await sendInitialMessage();
//       }
//
//       isLoading.value = false;
//     } catch (e) {
//       error.value = 'Failed to initialize user ID: $e';
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> sendInitialMessage() async {
//     try {
//       await sendMessage("Chat started");
//     } catch (e) {
//       error.value = 'Failed to send initial message: $e';
//     }
//   }
//
//   Stream<List<MessageModel>> fetchMessages() async* {
//     if (currentChatId.value.isEmpty) return;
//
//     try {
//       FirebaseFirestore.instance
//           .collection('Users')
//           .doc(currentUserId.value)
//           .collection('Chats')
//           .doc(currentChatId.value)
//           .collection('Messages')
//           .orderBy('timestamp')
//           .snapshots()
//           .listen((snapshot) {
//         final messagesList = snapshot.docs.map((doc) {
//           return MessageModel(
//             messageId: doc.id,
//             senderId: doc['senderId'],
//             messageText: doc['messageText'],
//             timestamp: doc['timestamp'].toDate(),
//             isRead: doc['isRead'],
//           );
//         }).toList();
//
//         messages.value = messagesList;
//       });
//     } catch (e) {
//       error.value = 'Failed to fetch messages: $e';
//     }
//   }
//
//   Future<void> sendMessage(String messageText) async {
//     if (messageText.isEmpty || currentUserId.value.isEmpty) {
//       error.value = 'Message text or User ID cannot be empty';
//       return;
//     }
//
//     try {
//       if (currentChatId.value.isEmpty) {
//         currentChatId.value = Uuid().v4();
//       }
//
//       final userDoc = FirebaseFirestore.instance.collection('Users').doc(currentUserId.value);
//       final chatRef = userDoc.collection('Chats').doc(currentChatId.value);
//       final messagesRef = chatRef.collection('Messages');
//
//       final docSnapshot = await chatRef.get();
//       if (!docSnapshot.exists) {
//         await chatRef.set({
//           'createdAt': Timestamp.now(),
//           'updatedAt': Timestamp.now(),
//           'lastMessage': '',
//           'lastMessageTimestamp': Timestamp.now(),
//           'participants': [currentUserId.value],
//         });
//       }
//
//       await messagesRef.add({
//         'senderId': currentUserId.value,
//         'messageText': messageText,
//         'timestamp': Timestamp.now(),
//         'isRead': false,
//       });
//
//       await chatRef.update({
//         'lastMessage': messageText,
//         'lastMessageTimestamp': Timestamp.now(),
//         'updatedAt': Timestamp.now(),
//       });
//
//       messageController.clear();
//       updateTypingStatus(false);
//     } catch (e) {
//       error.value = 'Failed to send message: $e';
//     }
//   }
//
//   void updateTypingStatus(bool isTyping) {
//     if (currentChatId.value.isEmpty || currentUserId.value.isEmpty) {
//       error.value = 'Chat ID or User ID cannot be empty';
//       return;
//     }
//
//     try {
//       FirebaseFirestore.instance
//           .collection('Users')
//           .doc(currentUserId.value)
//           .collection('Chats')
//           .doc(currentChatId.value)
//           .update({'typing': isTyping ? currentUserId.value : ''});
//       this.isTyping.value = isTyping;
//     } catch (e) {
//       error.value = 'Failed to update typing status: $e';
//     }
//   }
// }


// User Chat Controller
class UserChatController extends GetxController {
  var currentChatId = ''.obs;
  var currentUserId = ''.obs;
  var messages = <MessageModel>[].obs;
  var isTyping = false.obs;
  var isLoading = true.obs;
  var error = ''.obs;

  final TextEditingController messageController = TextEditingController();
  final AuthenticationRepository _authRepo = AuthenticationRepository.instance;

  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(currentChatId, (_) => fetchMessages());
    initializeUserId();
  }

  Future<void> initializeUserId() async {
    try {
      isLoading.value = true;
      error.value = '';

      User? currentUser = _authRepo.currentAuthUser;

      if (currentUser == null) {
        throw Exception('User is not authenticated');
      }

      currentUserId.value = currentUser.uid;

      final userDoc = FirebaseFirestore.instance.collection('Users').doc(currentUserId.value);

      final existingChats = await userDoc.collection('Chats').limit(1).get();

      if (existingChats.docs.isNotEmpty) {
        currentChatId.value = existingChats.docs.first.id;
      } else {
        currentChatId.value = Uuid().v4();
        await sendInitialMessage();
      }

      isLoading.value = false;
    } catch (e) {
      error.value = 'Failed to initialize user ID: $e';
      isLoading.value = false;
    }
  }

  Future<void> sendInitialMessage() async {
    try {
      await sendMessage("Chat started");
    } catch (e) {
      error.value = 'Failed to send initial message: $e';
    }
  }

  // Stream<List<MessageModel>> fetchMessages() {
  //   if (currentChatId.value.isEmpty) return Stream.value([]);
  //
  //   try {
  //     return FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(currentUserId.value)
  //         .collection('Chats')
  //         .doc(currentChatId.value)
  //         .collection('Messages')
  //         .orderBy('timestamp')
  //         .snapshots()
  //         .map((snapshot) {
  //       return snapshot.docs.map((doc) {
  //         return MessageModel(
  //           messageId: doc.id,
  //           senderId: doc['senderId'],
  //           messageText: doc['messageText'],
  //           timestamp: doc['timestamp'].toDate(),
  //           isRead: doc['isRead'],
  //         );
  //       }).toList();
  //     });
  //   } catch (e) {
  //     error.value = 'Failed to fetch messages: $e';
  //     return Stream.value([]);
  //   }
  // }
  Stream<List<MessageModel>> fetchMessages() {
    if (currentChatId.value.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserId.value)
        .collection('Chats')
        .doc(currentChatId.value)
        .collection('Messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel(
          messageId: doc.id,
          senderId: doc['senderId'],
          messageText: doc['messageText'],
          timestamp: doc['timestamp'].toDate(),
          isRead: doc['isRead'],
        );
      }).toList();
    }).handleError((error) {
      print('Error fetching messages: $error');
      throw error;
    });
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.isEmpty || currentUserId.value.isEmpty) {
      error.value = 'Message text or User ID cannot be empty';
      return;
    }

    try {
      if (currentChatId.value.isEmpty) {
        currentChatId.value = Uuid().v4();
      }

      final userDoc = FirebaseFirestore.instance.collection('Users').doc(currentUserId.value);
      final chatRef = userDoc.collection('Chats').doc(currentChatId.value);
      final messagesRef = chatRef.collection('Messages');

      final docSnapshot = await chatRef.get();
      if (!docSnapshot.exists) {
        await chatRef.set({
          'createdAt': Timestamp.now(),
          'updatedAt': Timestamp.now(),
          'lastMessage': '',
          'lastMessageTimestamp': Timestamp.now(),
          'participants': [currentUserId.value],
        });
      }

      await messagesRef.add({
        'senderId': currentUserId.value,
        'messageText': messageText,
        'timestamp': Timestamp.now(),
        'isRead': false,
      });

      await chatRef.update({
        'lastMessage': messageText,
        'lastMessageTimestamp': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });

      messageController.clear();
      updateTypingStatus(false);
    } catch (e) {
      error.value = 'Failed to send message: $e';
    }
  }

  void updateTypingStatus(bool isTyping) {
    if (currentChatId.value.isEmpty || currentUserId.value.isEmpty) {
      error.value = 'Chat ID or User ID cannot be empty';
      return;
    }

    try {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserId.value)
          .collection('Chats')
          .doc(currentChatId.value)
          .update({'typing': isTyping ? currentUserId.value : ''});
      this.isTyping.value = isTyping;
    } catch (e) {
      error.value = 'Failed to update typing status: $e';
    }
  }

  Stream<List<MessageModel>> getMessagesForChat(String chatId) {
    if (chatId.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserId.value)
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
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
      print('Error fetching messages for user: $error');
      throw error;
    });
  }

}