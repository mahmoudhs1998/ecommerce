// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'models.dart';
// import 'new_controller.dart';
//
// class UserChatScreensss extends StatelessWidget {
//   final UserChatControllersss controller = Get.put(UserChatControllersss());
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
//         return Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: ChatsList(controller: controller),
//             ),
//             Expanded(
//               flex: 3,
//               child: ChatWindow(controller: controller),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
// class ChatsList extends StatelessWidget {
//   final UserChatControllersss controller;
//
//   ChatsList({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     ChatModel ? chatModel;
//     return StreamBuilder<List<ChatModel>>(
//       stream: controller.getChats(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//
//         final chats = snapshot.data ?? [];
//         print('ChatsList: ${chats.length} chats found'); // Debugging line
//         if (chats.isEmpty) {
//           return Center(child: Text('No chats available.'));
//         }
//
//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (context, index) {
//             final chat = chats[index];
//             return ListTile(
//               title: Text('Chat with ${chat.chatId}'),
//               subtitle: Text(chat.lastMessage!),
//               onTap: () {
//                 controller.selectedChatId.value = chat.chatId;
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// // class ChatWindow extends StatelessWidget {
// //   final UserChatControllersss controller;
// //
// //   ChatWindow({required this.controller});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       if (controller.selectedChatId.value.isEmpty) {
// //         return Center(child: Text('Select a chat to view messages.'));
// //       }
// //
// //       return StreamBuilder<List<MessageModel>>(
// //         stream: controller.getMessagesForChat(controller.selectedChatId.value),
// //         builder: (context, messageSnapshot) {
// //           if (messageSnapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (messageSnapshot.hasError) {
// //             return Center(child: Text('Error: ${messageSnapshot.error}'));
// //           }
// //
// //           final messages = messageSnapshot.data ?? [];
// //           if (messages.isEmpty) {
// //             return Center(child: Text('No messages yet.'));
// //           }
// //
// //           return Column(
// //             children: [
// //               Expanded(
// //                 child: ListView.builder(
// //                   reverse: true,
// //                   itemCount: messages.length,
// //                   itemBuilder: (context, index) {
// //                     final message = messages[index];
// //                     return ListTile(
// //                       title: Text(message.messageText),
// //                       subtitle: Text('${message.senderId} - ${message.timestamp}'),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       child: TextField(
// //                         controller: controller.messageController,
// //                         decoration: InputDecoration(
// //                           hintText: 'Type your message...',
// //                           border: OutlineInputBorder(),
// //                         ),
// //                       ),
// //                     ),
// //                     IconButton(
// //                       icon: Icon(Icons.send),
// //                       onPressed: () {
// //                         final messageText = controller.messageController.text.trim();
// //                         if (messageText.isNotEmpty) {
// //                           controller.sendMessage(messageText);
// //                         }
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     });
// //   }
// // }
//
//
// class ChatWindow extends StatelessWidget {
//   final UserChatControllersss controller;
//
//   ChatWindow({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.selectedChatId.value.isEmpty) {
//         return Center(child: Text('Select a chat to view messages.'));
//       }
//
//       return StreamBuilder<List<MessageModel>>(
//         stream: controller.getMessagesForChat(controller.selectedChatId.value),
//         builder: (context, messageSnapshot) {
//           if (messageSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (messageSnapshot.hasError) {
//             return Center(child: Text('Error: ${messageSnapshot.error}'));
//           }
//
//           final messages = messageSnapshot.data ?? [];
//           if (messages.isEmpty) {
//             return Center(child: Text('No messages yet.'));
//           }
//
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     final isCurrentUser = message.senderId == controller.userId.value;
//
//                     return Align(
//                       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                         decoration: BoxDecoration(
//                           color: isCurrentUser ? Colors.blue[200] : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               message.messageText,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               '${message.timestamp}',
//                               style: TextStyle(fontSize: 12, color: Colors.black54),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: controller.messageController,
//                         decoration: InputDecoration(
//                           hintText: 'Type your message...',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send),
//                       onPressed: () {
//                         final messageText = controller.messageController.text.trim();
//                         if (messageText.isNotEmpty) {
//                           controller.sendMessage(messageText);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'models.dart';
import 'new_controller.dart';

// class UserChatScreenaaa extends StatelessWidget {
//   final UserChatControlleraaa controller = Get.put(UserChatControlleraaa());
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
//         return Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: AdminsList(controller: controller),
//             ),
//             Expanded(
//               flex: 3,
//               child: ChatWindow(controller: controller),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text('User Chat')),
//     body: Column(
//       children: [
//         Obx(() {
//           if (userChatController.isLoading.value) {
//             return CircularProgressIndicator();
//           }
//
//           if (userChatController.adminIds.isEmpty) {
//             return Text('No admins available');
//           }
//
//           return Expanded(
//             child: ListView.builder(
//               itemCount: userChatController.adminIds.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(userChatController.adminIds[index]),
//                   onTap: () {
//                     userChatController.selectedAdminId.value = userChatController.adminIds[index];
//                   },
//                 );
//               },
//             ),
//           );
//         }),
//         Obx(() {
//           if (userChatController.selectedAdminId.isEmpty) {
//             return Text('Select an admin to chat with');
//           }
//
//           return StreamBuilder<List<ChatModel>>(
//             stream: userChatController.getChatsForAdmin(userChatController.selectedAdminId.value),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }
//
//               if (snapshot.hasError) {
//                 return Text('Error fetching chats');
//               }
//
//               final chats = snapshot.data;
//
//               if (chats == null || chats.isEmpty) {
//                 return Text('No chats for selected admin');
//               }
//
//               final chatId = chats.first.chatId;
//
//               return StreamBuilder<List<MessageModel>>(
//                 stream: userChatController.getMessagesForChat(chatId),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   }
//
//                   if (snapshot.hasError) {
//                     return Text('Error fetching messages');
//                   }
//
//                   final messages = snapshot.data;
//
//                   if (messages == null || messages.isEmpty) {
//                     return Text('No messages');
//                   }
//
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: messages.length,
//                       itemBuilder: (context, index) {
//                         final message = messages[index];
//                         return ListTile(
//                           title: Text(message.messageText),
//                           subtitle: Text(message.timestamp.toString()),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         }),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: userChatController.messageController,
//                   decoration: InputDecoration(hintText: 'Enter message'),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 onPressed: () {
//                   userChatController.sendMessage(userChatController.messageController.text);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );

// }



class UserChatScreenaaa extends StatelessWidget {
  final UserChatControlleraaa userChatController = Get.put(UserChatControlleraaa());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Chat')),
      body: Column(
        children: [
          Obx(() {
            if (userChatController.isLoading.value) {
              return CircularProgressIndicator();
            }

            if (userChatController.adminIds.isEmpty) {
              return Text('No admins available');
            }

            return Expanded(
              child: ListView.builder(
                itemCount: userChatController.adminIds.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userChatController.adminIds[index]),
                    onTap: () {
                      userChatController.selectedAdminId.value = userChatController.adminIds[index];
                    },
                  );
                },
              ),
            );
          }),
          Obx(() {
            if (userChatController.selectedAdminId.isEmpty) {
              return Text('Select an admin to chat with');
            }

            return StreamBuilder<List<ChatModel>>(
              stream: userChatController.getChatsForAdmin(userChatController.selectedAdminId.value),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error fetching chats');
                }

                final chats = snapshot.data;

                if (chats == null || chats.isEmpty) {
                  return Text('No chats for selected admin');
                }

                final chatId = chats.first.chatId;

                return StreamBuilder<List<MessageModel>>(
                  stream: userChatController.getMessagesForChat(chatId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error fetching messages');
                    }

                    final messages = snapshot.data;

                    if (messages == null || messages.isEmpty) {
                      return Text('No messages');
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return ListTile(
                            title: Text(message.messageText),
                            subtitle: Text(message.timestamp.toString()),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: userChatController.messageController,
                    decoration: InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    userChatController.sendMessage(userChatController.messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}

class ChatWindow extends StatelessWidget {
  final UserChatControlleraaa controller;

  ChatWindow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedAdminId.value.isEmpty) {
        return Center(child: Text('Select an admin to start chatting.'));
      }

      return StreamBuilder<List<ChatModel>>(
        stream: controller.getChatsForAdmin(controller.selectedAdminId.value),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (chatSnapshot.hasError) {
            return Center(child: Text('Error: ${chatSnapshot.error}'));
          }

          final chats = chatSnapshot.data ?? [];
          if (chats.isEmpty) {
            return Center(child: Text('No chats available for this admin.'));
          }

          final chatId = chats.first.chatId;

          return Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: controller.getMessagesForChat(chatId),
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

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        bool isUser = message.senderId == controller.userId.value;
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.blue[100] : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.messageText,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  DateFormat('HH:mm').format(message.timestamp),
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        controller.sendMessage(controller.messageController.text);
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

class AdminsList extends StatelessWidget {
  final UserChatControlleraaa controller;

  AdminsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.adminIds.length,
        itemBuilder: (context, index) {
          final adminId = controller.adminIds[index];
          return ListTile(
            title: Text(adminId),
            onTap: () {
              controller.selectedAdminId.value = adminId;
            },
          );
        },
      );
    });
  }
}
