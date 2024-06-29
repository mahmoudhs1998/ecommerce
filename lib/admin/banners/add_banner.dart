// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'controller/admin_banner_controller.dart';

// class AddBannerPage extends StatelessWidget {
//   final AdminBannerController _controller = Get.put(AdminBannerController());

//   AddBannerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Banner'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Obx(() {
//               return _controller.imageUrl.value.isEmpty
//                   ? Text('No image selected.')
//                   : Image.network(_controller.imageUrl.value,
//                       height: 200, width: 200);
//             }),
//             ElevatedButton(
//               onPressed: _controller.pickImage,
//               child: Text('Pick Image'),
//             ),
//             TextField(
//               controller: _controller.targetScreenController,
//               decoration: InputDecoration(
//                 labelText: 'Target Screen',
//                 errorText: _controller.targetScreenError.value.isEmpty
//                     ? null
//                     : _controller.targetScreenError.value,
//               ),
//             ),
//             Obx(() => CheckboxListTile(
//                   title: Text('Active'),
//                   value: _controller.active.value,
//                   onChanged: (value) {
//                     _controller.active.value = value!;
//                   },
//                 )),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _controller.addBanner,
//               child: Text('Add Banner'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/admin_banner_controller.dart';

class AddBannerPage extends StatelessWidget {
  final AdminBannerController _controller = Get.put(AdminBannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Banner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return _controller.imageUrl.value.isEmpty
                  ? Text('No image selected.')
                  : Image.network(
                      _controller.imageUrl.value,
                      height: 200,
                      width: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Failed to load image');
                      },
                    );
            }),
            ElevatedButton(
              onPressed: _controller.pickImage,
              child: Text('Pick Image'),
            ),
            TextField(
              controller: _controller.targetScreenController,
              decoration: InputDecoration(
                labelText: 'Target Screen',
                errorText: _controller.targetScreenError.value.isEmpty
                    ? null
                    : _controller.targetScreenError.value,
              ),
            ),
            Obx(() => CheckboxListTile(
                  title: Text('Active'),
                  value: _controller.active.value,
                  onChanged: (value) {
                    _controller.active.value = value!;
                  },
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _controller.addBanner,
              child: Text('Add Banner'),
            ),
          ],
        ),
      ),
    );
  }
}
