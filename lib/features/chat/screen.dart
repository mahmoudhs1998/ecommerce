import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/authentication/authentication_repository.dart';
import 'controller.dart';
import 'models.dart';


// class UserChatScreen extends StatelessWidget {
//   final UserChatController chatController = Get.put(UserChatController());
//
//   UserChatScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => Text(chatController.currentChatId.value.isEmpty
//             ? 'New Chat'
//             : 'Chat ${chatController.currentChatId.value.substring(0, 8)}...')),
//       ),
//       body: Obx(() {
//         if (chatController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (chatController.error.value.isNotEmpty) {
//           return Center(child: Text(chatController.error.value));
//         }
//
//         return Column(
//           children: [
//             Expanded(
//               child: chatController.messages.isEmpty
//                   ? Center(child: Text('Initializing chat...'))
//                   : ListView.builder(
//                 itemCount: chatController.messages.length,
//                 itemBuilder: (context, index) {
//                   var message = chatController.messages[index];
//                   bool isSentByUser = message.senderId == chatController.currentUserId.value;
//
//                   return MessageBubble(
//                     message: message,
//                     isSentByUser: isSentByUser,
//                   );
//                 },
//               ),
//             ),
//             Obx(() {
//               return chatController.isTyping.value
//                   ? Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('User is typing...'),
//               )
//                   : SizedBox.shrink();
//             }),
//             MessageInput(
//               controller: chatController.messageController,
//               onChanged: (text) {
//                 if (chatController.currentChatId.value.isNotEmpty &&
//                     chatController.currentUserId.value.isNotEmpty) {
//                   chatController.updateTypingStatus(text.isNotEmpty);
//                 }
//               },
//               onSubmitted: (text) {
//                 if (chatController.currentChatId.value.isNotEmpty &&
//                     chatController.currentUserId.value.isNotEmpty) {
//                   chatController.sendMessage(text);
//                 }
//               },
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }



// class UserChatScreen extends StatelessWidget {
//   final UserChatController controller = Get.put(UserChatController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Chat'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.error.value.isNotEmpty) {
//           return Center(child: Text('Error: ${controller.error.value}'));
//         }
//
//         return Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<List<MessageModel>>(
//                 stream: controller.fetchMessages(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//
//                   final messages = snapshot.data!;
//
//                   return ListView.builder(
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return ListTile(
//                         title: Text(message.messageText),
//                         subtitle: Text('Sent by: ${message.senderId}'),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller.messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                       ),
//                       onChanged: (text) {
//                         controller.updateTypingStatus(text.isNotEmpty);
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.send),
//                     onPressed: () {
//                       controller.sendMessage(controller.messageController.text);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

//
// // User Chat Screen
// class UserChatScreen extends StatelessWidget {
//   final UserChatController controller = Get.put(UserChatController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Chat'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.error.value.isNotEmpty) {
//           return Center(child: Text('Error: ${controller.error.value}'));
//         }
//
//         return Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<List<MessageModel>>(
//                 stream: controller.fetchMessages(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//
//                   final messages = snapshot.data!;
//
//                   return ListView.builder(
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       return ListTile(
//                         title: Text(message.messageText),
//                         subtitle: Text('Sent by: ${message.senderId}'),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller.messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                       ),
//                       onChanged: (text) {
//                         controller.updateTypingStatus(text.isNotEmpty);
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.send),
//                     onPressed: () {
//                       controller.sendMessage(controller.messageController.text);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
// class MessageBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isSentByUser; // or isSentByAdmin for Admin version
//
//   MessageBubble({required this.message, required this.isSentByUser});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.all(8.0),
//         margin: EdgeInsets.all(4.0),
//         decoration: BoxDecoration(
//           color: isSentByUser ? Colors.blue : Colors.grey,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Text(
//           message.messageText,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
//
// class MessageInput extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onChanged;
//   final Function(String) onSubmitted;
//
//   MessageInput({required this.controller, required this.onChanged, required this.onSubmitted});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller,
//               onChanged: onChanged,
//               onSubmitted: onSubmitted,
//               decoration: InputDecoration(
//                 hintText: 'Type a message',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () => onSubmitted(controller.text),
//           ),
//         ],
//       ),
//     );
//   }
// }


class UserChatScreennnnnnnnnnnnnn extends StatelessWidget {
  final UserChatController controller = Get.put(UserChatController());

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

        return Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: controller.fetchMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final messages = snapshot.data!;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByUser = message.senderId == controller.userId.value;

                      return MessageBubble(
                        message: message,
                        isSentByUser: isSentByUser,
                      );
                    },
                  );
                },
              ),
            ),
            MessageInput(
              controller: controller.messageController,
              onChanged: (text) {
                controller.updateTypingStatus(text.isNotEmpty);
              },
              onSubmitted: (text) {
                controller.sendMessage(text);
              },
            ),
          ],
        );
      }),
    );
  }
}
class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isSentByUser;

  MessageBubble({required this.message, required this.isSentByUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSentByUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          message.messageText,
          style: TextStyle(color: isSentByUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  MessageInput({required this.controller, required this.onChanged, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => onSubmitted(controller.text),
          ),
        ],
      ),
    );
  }
}
