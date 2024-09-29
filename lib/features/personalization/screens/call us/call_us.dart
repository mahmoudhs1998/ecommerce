import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/call_us_controller.dart';

class ContactPage extends StatelessWidget {
  final CallController callController = Get.put(CallController());

  // Example list of random numbers
  final List<String> contactNumbers = [
    '+201144357587',
    '+0987654321',
    '+1122334455',
    '+5566778899',
    '+9988776655',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: ListView.builder(
        itemCount: contactNumbers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.phone),
            title: Text(contactNumbers[index]),
            onTap: () {
              callController.callUs(contactNumbers[index]);
            },
          );
        },
      ),
    );
  }
}
