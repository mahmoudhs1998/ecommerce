import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';
import 'widgets/single_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ), // TapAppBar
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:  Obx(
            ()=> FutureBuilder(
              // Use Key to Trigger Refresh
              key:Key(addressController.refreshData.value.toString()) ,
              future: addressController.getAllUserAddresses(),
              builder: (context, snapshot) {

                /// Helper Function: Handle Loader, No Record, OR ERROR Messoge
                final response = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if (response != null) return response;

                final addresses = snapshot.data!;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder:(_,index)=> SingleAddressWidget(
                      address: addresses[index],
                      onTap: ()=>addressController.selectAddress(addresses[index]),
                    ));
              }
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primaryColor,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Icons.add, color: TColors.white),
      ),
    );
  }
}
