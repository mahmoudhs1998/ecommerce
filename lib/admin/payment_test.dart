// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myfatoorah_flutter/MFEnums.dart';
// import 'package:myfatoorah_flutter/MFModels.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
//
// void main() {
//   runApp(
//     GetMaterialApp(
//       title: "MyFatoorah Payment Demo",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//       initialBinding: PaymentBinding(),
//     ),
//   );
// }
//
// class AppPages {
//   AppPages._();
//
//   static const INITIAL = Routes.PAYMENT;
//
//   static final routes = [
//     GetPage(
//       name: _Paths.PAYMENT,
//       page: () => PaymentPage(),
//       binding: PaymentBinding(),
//     ),
//   ];
// }
//
// abstract class Routes {
//   Routes._();
//   static const PAYMENT = _Paths.PAYMENT;
// }
//
// abstract class _Paths {
//   _Paths._();
//   static const PAYMENT = '/payment';
// }
// class PaymentBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<PaymentService>(() => PaymentService());
//     Get.lazyPut<PaymentController>(() => PaymentController());
//   }
// }
//
//
//
// class PaymentService extends GetxService {
//   @override
//   void onInit() {
//     super.onInit();
//     initPlugin();
//   }
//
//   void initPlugin() {
//     // Initialize MyFatoorah with your API key, country, and environment
//     MFSDK.init("your_api_key_here", MFCountry.EGYPT, MFEnvironment.TEST);
//
//     // Optionally set up the app bar for MyFatoorah screens
//     MFSDK.setUpActionBar(
//       toolBarTitle: 'Payment',
//       toolBarTitleColor: '#FFFFFF',
//       toolBarBackgroundColor: '#000000',
//       isShowToolBar: true,
//     );
//   }
//
//   Future<void> initiatePayment(double amount) async {
//     var request = MFInitiatePaymentRequest(
//       invoiceAmount: amount,
//       currencyIso: MFCurrencyISO.SAUDIARABIA_SAR,
//     );
//
//     try {
//       var response = await MFSDK.initiatePayment(request, MFLanguage.ENGLISH);
//       print("Payment methods: ${response.paymentMethods}");
//     } catch (e) {
//       print("Error initiating payment: $e");
//     }
//   }
//
//   Future<void> executePayment(int paymentMethodId, double amount) async {
//     var request = MFExecutePaymentRequest(invoiceValue: amount);
//     request.paymentMethodId = paymentMethodId;
//
//     try {
//       var response = await MFSDK.executePayment(
//         request,
//         MFLanguage.ENGLISH,
//             (invoiceId) {
//           print("Invoice ID: $invoiceId");
//         },
//       );
//       print("Execute Payment Response: $response");
//     } catch (e) {
//       print("Error executing payment: $e");
//     }
//   }
//
//   Future<void> getPaymentStatus(String invoiceId) async {
//     var request = MFGetPaymentStatusRequest(
//       key: invoiceId,
//       keyType: MFKeyType.INVOICEID.camelCase,
//     );
//
//     try {
//       var response = await MFSDK.getPaymentStatus(request, MFLanguage.ENGLISH);
//       print("Payment Status: $response");
//     } catch (e) {
//       print("Error fetching payment status: $e");
//     }
//   }
// }
// class PaymentController extends GetxController {
//   final PaymentService _paymentService = Get.find<PaymentService>();
//
//   Future<void> initiatePayment(double amount) async {
//     await _paymentService.initiatePayment(amount);
//   }
//
//   Future<void> executePayment(int paymentMethodId, double amount) async {
//     await _paymentService.executePayment(paymentMethodId, amount);
//   }
//
//   Future<void> checkPaymentStatus(String invoiceId) async {
//     await _paymentService.getPaymentStatus(invoiceId);
//   }
// }
//
//
//
// class PaymentPage extends StatelessWidget {
//   final PaymentController _controller = Get.put(PaymentController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () => _controller.initiatePayment(100.0),
//               child: Text('Initiate Payment'),
//             ),
//             ElevatedButton(
//               onPressed: () => _controller.executePayment(1, 100.0),
//               child: Text('Execute Payment with Method ID 1'),
//             ),
//             ElevatedButton(
//               onPressed: () => _controller.checkPaymentStatus('invoice_id_here'),
//               child: Text('Check Payment Status'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
const String token  = "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Test'),
      ),
      body: Column(
        children: [
      
          Center(
            child: ElevatedButton(
              onPressed: () async {
                var response = await MyFatoorah.startPayment(
                  context: context,
                  request: MyfatoorahRequest.test(
                    currencyIso: Country.SaudiArabia,
                    successUrl: 'https://www.facebook.com',
                    errorUrl: 'https://www.google.com/',
                    invoiceAmount: 100,
                    language: ApiLanguage.English,
                    token:token,
                  ),
                );
                log(response.paymentId.toString());
                log(response.status.toString());
              },
              child: Text('Payment test'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> processPayment() async {
    // Simulate a payment process
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return true; // Simulate a successful payment
  }
}
