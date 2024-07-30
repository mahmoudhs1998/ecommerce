import 'package:ecommerce/admin/payment_test.dart';
import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'dart:developer'; // Import for logging

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

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) CircularProgressIndicator(),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: isLoading ? null : () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        var response = await MyFatoorah.startPayment(

                          context: context,
                          request: MyfatoorahRequest.test(

                            currencyIso: Country.SaudiArabia,
                            successUrl: 'https://th.bing.com/th?id=OIP.oUEzkTPkAKq3HNCesBlZlAHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
                            errorUrl: 'https://www.google.com/',
                            invoiceAmount: 100,
                            language: ApiLanguage.English,
                            token: token, // Replace with your actual token
                          ),
                        );
                        log(response.paymentId.toString());
                        log(response.status.toString());
                        if (response.status == PaymentStatus.Success) {
                          _showMessage('Payment Successful: ${response.paymentId}');
                        } else {
                          _showMessage('Payment Failed: ${response.status}');
                        }
                      } catch (e) {
                        log(e.toString());
                        _showMessage('An error occurred: $e');
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text('Payment Test'),
                  ),
                  ElevatedButton(onPressed: ()async{
                    await Navigator.push(context, MaterialPageRoute(builder: (context)=> const ListViewPage()));
                  }, child: Text("Payment ListView"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}




class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Payment ListView"),),

     body: MyFatoorah(
       onResult: (response) {
         log(response.paymentId.toString());
         log(response.status.toString());
       },
       request: MyfatoorahRequest.test(
         currencyIso: Country.SaudiArabia,
         successUrl: 'https://github.com/mahmoudhs1998',
         errorUrl: 'https://www.google.com',
         invoiceAmount: 100,//widget.cartDetails.total,
         language: ApiLanguage.Arabic,
         token:token
       ),
     ),
    );
  }
}
