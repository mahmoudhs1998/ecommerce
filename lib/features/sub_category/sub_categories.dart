import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/common/widgets/cart/product_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/rounded_image_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category_conotroller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/widgets/appbar/app_bar.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/cloud_helper_functions.dart';
import '../shop/controllers/product/product_controller.dart';
import '../shop/models/product_model.dart';
import '../shop/screens/product_details/product_details_screen.dart';

//
//
// class SubCategoriesScreen extends StatelessWidget {
//   final CategoryModel category;
//   const SubCategoriesScreen({super.key, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     final adminSubCategoryController = Get.put(AdminSubCategoryController());
//
//     return Scaffold(
//       appBar: TAppBar(title: Text(category.name), showBackArrow: true),
//       body: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: Column(
//           children: [
//             // -- Banner
//             TRoundedImage(
//               isNetworkImage: true,
//               imageUrl: category.image,
//               width: double.infinity,
//               applyImageRadius: true,
//             ),
//             const SizedBox(height: TSizes.spaceBtwSections),
//
//             // -- Sub Categories
//             Obx(() {
//               print('Subcategories fetched: ${adminSubCategoryController.subCategories.length}');
//
//               final subCategories = adminSubCategoryController.subCategories
//                   .where((subCategory) => subCategory.parentId == category.id)
//                   .toList();
//
//               print('Filtered subcategories: ${subCategories.length} for parentId: ${category.id}');
//
//               if (subCategories.isEmpty) {
//                 return const Text('No subcategories found.');
//               }
//
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: subCategories.length,
//                 itemBuilder: (_, index) {
//                   final subCategory = subCategories[index];
//                   print('Building UI for subcategory: ${subCategory.name}');
//
//                   return FutureBuilder<List<ProductModel>>(
//                     future: adminSubCategoryController.subCategoryRepository.getCategoryProducts(categoryId: subCategory.id),
//                     builder: (context, snapshot) {
//                       print('Fetching products for subcategory: ${subCategory.id}');
//                       print('Snapshot connection state: ${snapshot.connectionState}');
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const CircularProgressIndicator();
//                       }
//
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.hasError) {
//                           print('Error fetching products: ${snapshot.error}');
//                           return Text('Error: ${snapshot.error}');
//                         }
//                         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                           print('No products found for subcategory: ${subCategory.name}');
//                           return const Text('No products found.');
//                         }
//                         final products = snapshot.data!;
//                         print('Products fetched for subcategory ${subCategory.name}: ${products.length}');
//
//                         return Column(
//                           children: [
//                             // -- Heading
//                             TCategoriesSectionHeading(
//                               title: subCategory.name,
//                               onPressed: () => Get.to(
//                                     () => AllProducts(
//                                   title: subCategory.name,
//                                   futureMethod: adminSubCategoryController.subCategoryRepository.getCategoryProducts(categoryId: subCategory.id, limit: -1),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: TSizes.spaceBtwItems / 2),
//                             SizedBox(
//                               height: 120,
//                               child: ListView.separated(
//                                 itemCount: products.length,
//                                 scrollDirection: Axis.horizontal,
//                                 separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
//                                 itemBuilder: (context, index) => TProductCardHorizontal(product: products[index]),
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//
//                       return const CircularProgressIndicator();
//                     },
//                   );
//                 },
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class SubCategoryRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _productsPath = 'Products';
//   final String _subCategoriesPath = 'subCategories';
//
//   Future<String> getCategoryParentId(String categoryId) async {
//     try {
//       print('Fetching parent ID for category: $categoryId');
//       DocumentSnapshot docSnapshot = await _firestore
//           .collection(_subCategoriesPath)
//           .doc(categoryId)
//           .get();
//
//       if (docSnapshot.exists) {
//         Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
//         String parentId = data['ParentId'] as String? ?? '';
//         print('Parent ID for category $categoryId is: $parentId');
//         return parentId;
//       } else {
//         print('Category document not found for ID: $categoryId');
//         return '';
//       }
//     } catch (e) {
//       print('Error fetching parent ID for category $categoryId: $e');
//       return '';
//     }
//   }
//
//   Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 10}) async {
//     try {
//       print('Fetching products for category/subcategory $categoryId with limit $limit');
//       String parentId = await getCategoryParentId(categoryId);
//
//       QuerySnapshot querySnapshot = await _firestore
//           .collection(_productsPath)
//           .where('categoryId', whereIn: [categoryId, parentId])
//           .limit(limit)
//           .get();
//
//       print('Query snapshot size: ${querySnapshot.size}');
//       List<ProductModel> products = querySnapshot.docs.map((doc) {
//         print('Processing document ${doc.id}');
//         return ProductModel.fromQuerySnapshot(doc);
//       }).toList();
//
//       print('Fetched ${products.length} products for category/subcategory $categoryId');
//       return products;
//     } catch (e) {
//       print('Error fetching products for category/subcategory $categoryId: $e');
//       return [];
//     }
//   }
//   Stream<List<CategoryModel>> getSubCategories() {
//     return _firestore.collection(_subCategoriesPath).snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
//     });
//   }
//
//   Stream<List<CategoryModel>> getMainCategories() {
//     return _firestore.collection(_subCategoriesPath)
//         .where('ParentId', isEqualTo: '')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
//     });
//   }
//
// }
//
// class AdminSubCategoryController extends GetxController {
//   final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
//   final TextEditingController nameController = TextEditingController();
//   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
//   final RxBool isFeatured = RxBool(false);
//
//   RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
//   RxList<CategoryModel> mainCategories = <CategoryModel>[].obs;
//   Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
//
//   final GlobalKey<FormState> addSubCategoryFormKey = GlobalKey<FormState>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getSubCategories();
//     getMainCategories();
//   }
//
//   void getSubCategories() {
//     subCategoryRepository.getSubCategories().listen((updatedSubCategories) {
//       subCategories.value = updatedSubCategories;
//     });
//   }
//
//   void getMainCategories() {
//     subCategoryRepository.getMainCategories().listen((updatedMainCategories) {
//       mainCategories.value = updatedMainCategories;
//     });
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = image;
//     }
//   }
//
//
//
//   void resetForm() {
//     nameController.clear();
//     selectedImage.value = null;
//     selectedCategory.value = null;
//     isFeatured.value = false;
//   }
//
//   void setSubCategoryForEdit(CategoryModel subCategory) {
//     nameController.text = subCategory.name;
//     selectedCategory.value = mainCategories.firstWhereOrNull((cat) => cat.id == subCategory.parentId);
//     isFeatured.value = subCategory.isFeatured;
//   }
// }



class SubCategoriesScreen extends StatelessWidget {
  final CategoryModel category;
  const SubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final adminSubCategoryController = Get.put(AdminSubCategoryController());

    // Fetch subcategories for this specific category
    adminSubCategoryController.getSubCategories(category.id);

    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // -- Banner
            TRoundedImage(
              isNetworkImage: true,
              imageUrl: category.image,
              width: double.infinity,
              applyImageRadius: true,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // -- Sub Categories
            Obx(() {
              final subCategories = adminSubCategoryController.subCategories;
              print('Rendering ${subCategories.length} subcategories');

              if (subCategories.isEmpty) {
                return const Text('No subcategories found.');
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subCategories.length,
                itemBuilder: (_, index) {
                  final subCategory = subCategories[index];
                  print('Building UI for subcategory: ${subCategory.name} with data: ${subCategory.toJson()}');


                  return Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                      TCategoriesSectionHeading(
                      title: category.name,
                      showActionButton: true,
                      onPressed: () => Get.to(
                            () => AllSubCategories(
                          title: category.name,
                          futureMethod: adminSubCategoryController.getSubCategoriess(category.id),
                          //  futureMethod: adminSubCategoryController.getMainCategories(),
                        ),
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems,),

                    ListTile(
                          title: Text(subCategory.name),
                          leading: Image.network(subCategory.image),
                          onTap: () {
                            // Navigate to the ProductsScreen with the subCategory's CategoryId
                            Get.to(() => ProductScreen(
                              // categoryId: subCategory.id,
                              //categoryName: subCategory.name,
                            ));
                            // Handle subcategory tap
                            // You can navigate to another screen or perform any action here
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}


class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<void>(
          future: productController.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Obx(() {
                final products = productController.products;
                if (products.isEmpty) {
                  return const Center(child: Text('No products found.'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return
                      SizedBox(
                               height: 120,
                               child: ListView.separated(
                                 itemCount: products.length,
                                 scrollDirection: Axis.horizontal,
                                 separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                                 itemBuilder: (context, index) => GestureDetector(
                                   onTap: ()=> Get.to(()=> ProductDetailsScreen(product: product)),
                                     child: TProductCardHorizontal(product: product)
                                 ),
                               ),
                             );
                      //ProductCard(product: product);
                  },
                );
              });
            }
          },
        ),
      ),
    );
  }
}


































// Dummy ProductCard widget for displaying products
class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.title),
        subtitle: Text('Price: ${product.price}'),
      ),
    );
  }
}
class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Price: \$${product.price}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.description ?? ":",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Variations:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: product.productVariations?.length,
              itemBuilder: (context, index) {
                final variation = product.productVariations![index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Text('Variation ${index + 1}: ${variation.description}'),
                  subtitle: Text('Price: \$${variation.price}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// class SubCategoriesScreen extends StatelessWidget {
//   final CategoryModel category;
//   const SubCategoriesScreen({super.key, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     final adminSubCategoryController = Get.put(AdminSubCategoryController());
//
//     // Fetch subcategories for this specific category
//     adminSubCategoryController.getSubCategories(category.id);
//
//     return Scaffold(
//       appBar: TAppBar(title: Text(category.name), showBackArrow: true),
//       body: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: Column(
//           children: [
//             // -- Banner
//             TRoundedImage(
//               isNetworkImage: true,
//               imageUrl: category.image,
//               width: double.infinity,
//               applyImageRadius: true,
//             ),
//             const SizedBox(height: TSizes.spaceBtwSections),
//
//             // -- Sub Categories
//             Obx(() {
//               final subCategories = adminSubCategoryController.subCategories;
//               print('Rendering ${subCategories.length} subcategories');
//
//               if (subCategories.isEmpty) {
//                 return const Text('No subcategories found.');
//               }
//
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: subCategories.length,
//                 itemBuilder: (_, index) {
//                   final subCategory = subCategories[index];
//                   print('Building UI for subcategory: ${subCategory.name} with data: ${subCategory.toJson()}');
//
//                   return FutureBuilder<List<ProductModel>>(
//                     future: adminSubCategoryController.subCategoryRepository.getCategoryProducts(categoryId: subCategory.id),
//                     builder: (context, snapshot) {
//                       print('Fetching products for subcategory: ${subCategory.id}');
//                       print('Snapshot connection state: ${snapshot.connectionState}');
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const CircularProgressIndicator();
//                       }
//
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.hasError) {
//                           print('Error fetching products: ${snapshot.error}');
//                           return Text('Error: ${snapshot.error}');
//                         }
//                         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                           print('No products found for subcategory: ${subCategory.name}');
//                           return const Text('No products found.');
//                         }
//                         final products = snapshot.data!;
//                         print('Products fetched for subcategory ${subCategory.name}: ${products.length}');
//
//                         return Column(
//                           children: [
//                             // -- Heading
//                             TCategoriesSectionHeading(
//                               title: subCategory.name,
//                               onPressed: () => Get.to(
//                                     () => AllProducts(
//                                   title: subCategory.name,
//                                   futureMethod: adminSubCategoryController.subCategoryRepository.getCategoryProducts(categoryId: subCategory.id, limit: -1),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: TSizes.spaceBtwItems / 2),
//                             SizedBox(
//                               height: 120,
//                               child: ListView.separated(
//                                 itemCount: products.length,
//                                 scrollDirection: Axis.horizontal,
//                                 separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
//                                 itemBuilder: (context, index) => TProductCardHorizontal(product: products[index]),
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//
//                       return const CircularProgressIndicator();
//                     },
//                   );
//                 },
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class SubCategoryRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _productsPath = 'Products';
//   final String _subCategoriesPath = 'subCategories';
//   final String _categoriesPath = 'Categories';
//
//   Stream<List<CategoryModel>> getSubCategories(String parentCategoryId) {
//     print('Fetching subcategories for parent category ID: $parentCategoryId');
//     return _firestore
//         .collection(_subCategoriesPath)
//         .where('ParentId', isEqualTo: parentCategoryId)
//         .snapshots()
//         .map((snapshot) {
//       List<CategoryModel> subCategories = snapshot.docs.map((doc) {
//         print('Subcategory document data: ${doc.data()}');
//         return CategoryModel.fromSnapshot(doc);
//       }).toList();
//       print('Fetched ${subCategories.length} subcategories');
//       return subCategories;
//     });
//   }
//
//   Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 10}) async {
//     try {
//       print('Fetching products for category $categoryId with limit $limit');
//       QuerySnapshot querySnapshot = await _firestore
//           .collection(_productsPath)
//           .where('CategoryId', isEqualTo: categoryId)
//           .limit(limit)
//           .get();
//
//       print('Query snapshot size: ${querySnapshot.size}');
//       if (querySnapshot.size == 0) {
//         print('No products found for category $categoryId');
//       }
//
//       List<ProductModel> products = querySnapshot.docs.map((doc) {
//         print('Processing product document ${doc.id} with data: ${doc.data()}');
//         return ProductModel.fromQuerySnapshot(doc);
//       }).toList();
//
//       print('Fetched ${products.length} products for category $categoryId');
//       return products;
//     } catch (e) {
//       print('Error fetching products for category $categoryId: $e');
//       return [];
//     }
//   }
//
//   Stream<List<CategoryModel>> getMainCategories() {
//     return _firestore
//         .collection(_categoriesPath)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         print('Main category document data: ${doc.data()}');
//         return CategoryModel.fromSnapshot(doc);
//       }).toList();
//     });
//   }
// }

class SubCategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _subCategoriesPath = 'subCategories';
  final String _categoriesPath = 'Categories';

  Stream<List<CategoryModel>> getSubCategories(String parentCategoryId) {
    print('Fetching subcategories for parent category ID: $parentCategoryId');
    return _firestore
        .collection(_subCategoriesPath)
        .where('ParentId', isEqualTo: parentCategoryId)
        .snapshots()
        .map((snapshot) {
      List<CategoryModel> subCategories = snapshot.docs.map((doc) {
        print('Subcategory document data: ${doc.data()}');
        return CategoryModel.fromSnapshot(doc);
      }).toList();
      print('Fetched ${subCategories.length} subcategories');
      return subCategories;
    });
  }

  Stream<List<CategoryModel>> getMainCategories() {
    return _firestore
        .collection(_categoriesPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        print('Main category document data: ${doc.data()}');
        return CategoryModel.fromSnapshot(doc);
      }).toList();
    });
  }
}




class AdminSubCategoryController extends GetxController {
  final SubCategoryRepository subCategoryRepository = Get.put(SubCategoryRepository());
  final TextEditingController nameController = TextEditingController();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final RxBool isFeatured = RxBool(false);

  RxList<CategoryModel> subCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> mainCategories = <CategoryModel>[].obs;
  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);

  final GlobalKey<FormState> addSubCategoryFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getMainCategories();
  }

  // void getSubCategories(String parentCategoryId) {
  //   subCategoryRepository.getSubCategories(parentCategoryId).listen((updatedSubCategories) {
  //     print('Updated subcategories: $updatedSubCategories');
  //     subCategories.value = updatedSubCategories;
  //   });
  // }
  Future<List<CategoryModel>> getSubCategoriess(String parentCategoryId) async {
    final subCategoriesData = await subCategoryRepository
        .getSubCategories(parentCategoryId)
        .expand((element) => element)
        .toList();
    subCategories.assignAll(subCategoriesData);
    return subCategoriesData;
  }
  void getSubCategories(String parentCategoryId) {
    subCategoryRepository.getSubCategories(parentCategoryId).listen((subCategoriesData) {
      subCategories.assignAll(subCategoriesData);
    });
  }
  void getMainCategories() {
    subCategoryRepository.getMainCategories().listen((updatedMainCategories) {
      print('Updated main categories: $updatedMainCategories');
      mainCategories.value = updatedMainCategories;
    });
  }

  void resetForm() {
    nameController.clear();
    selectedImage.value = null;
    selectedCategory.value = null;
    isFeatured.value = false;
  }
}
