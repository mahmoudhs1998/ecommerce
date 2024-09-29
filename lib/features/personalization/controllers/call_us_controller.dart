import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CallController extends GetxController {
  Future<void> callUs(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      Get.snackbar('Error', 'Could not launch the phone dialer.');
    }
  }
}
