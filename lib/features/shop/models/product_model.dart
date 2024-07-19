// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce/features/shop/models/product_attribute_model.dart';
// import 'package:ecommerce/features/shop/models/product_variation_model.dart';

// import 'brand_model.dart';

// class ProductModel {
//   String id;
//   int stock;
//   String? sku;
//   double price;
//   String title;
//   DateTime? date;
//   double salePrice;
//   String thumbnail;
//   bool? isFeatured;
//   BrandModel? brand;
//   String? description;
//   String? categoryId;
//   List<String>? images;
//   String productType;
//   List<ProductAttributeModel>? productAttributes;
//   List<ProductVariationModel>? productVariations;

//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.stock,
//     required this.price,
//     required this.thumbnail,
//     required this.productType,
//     this.sku,
//     this.date,
//     this.salePrice = 0.0,
//     this.isFeatured,
//     this.brand,
//     this.description,
//     this.categoryId,
//     this.images,
//     this.productAttributes,
//     this.productVariations,
//   });

//   /// Create Empty Method for clean code
//   static ProductModel empty() => ProductModel(
//       id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

//   /// json format
//   toJson() {
//     return {
//       //'Id': id,
//       'Title': title,
//       'Stock': stock,
//       'Price': price,
//       'Thumbnail': thumbnail,
//       'ProductType': productType,
//       'SKU': sku,
//       'Date': date,
//       'SalePrice': salePrice,
//       'IsFeatured': isFeatured,
//       'Brand': brand!.toJson(),
//       'Description': description,
//       'CategoryId': categoryId,
//       'Images': images ?? [],
//       'ProductAttributes': productAttributes != null
//           ? productAttributes!.map((e) => e.toJson()).toList()
//           : [],
//       'ProductVariations': productVariations != null
//           ? productVariations!.map((e) => e.toJson()).toList()
//           : [],
//     };
//   }

//   /// Map Json oriented document snapshot from Firebase to Model
//   factory ProductModel.fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> document) {

//     if (document.data() == null) return ProductModel.empty();
//     final data = document.data()!;
//     ProductModel productModel = ProductModel(
//       id: document.id,
//       sku: data['SKU'],
//       title: data['Title'],
//       stock: data['Stock'] ?? 0.toString(),
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? '0.0').toString()),
//       salePrice: double.parse((data['SalePrice'] ?? '0.0').toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: data['ProductType'] ?? '',
//       brand: BrandModel.fromJson(data['Brand']),
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: (data['ProductAttributes'] as List<dynamic>)
//           .map((e) => ProductAttributeModel.fromJson(e))
//           .toList(),
//       productVariations: (data['ProductVariations'] as List<dynamic>)
//           .map((e) => ProductVariationModel.fromJson(e))
//           .toList(),
//     );
//     print(productModel.toJson());
//     return productModel; // ProductModel
//   }

//   /// Map Json oriented document snapshot from Firebase to Model
//   factory ProductModel.fromQuerySnapshot(
//       QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'] ?? '',
//       title: data['Title'] ?? '',
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? 0.0).toString()),
//       salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: data['ProductType'] ?? '',
//       brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//               .map((e) => ProductAttributeModel.fromJson(e))
//               .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//               .map((e) => ProductVariationModel.fromJson(e))
//               .toList()
//           : [],
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';

import '../screens/product_reviews/widgets/models.dart';
import '../screens/product_reviews/widgets/new_test_reviews.dart';
import 'brand_model.dart';

// class ProductModel {
//   String id;
//   int stock;
//   String? sku;
//   double price;
//   String title;
//   DateTime? date;
//   double salePrice;
//   String thumbnail;
//   bool? isFeatured;
//   NewBrandModel? brand;
//   String? description;
//   String? categoryId;
//   List<String>? images;
//   ProductType productType;
//   //String productType;
//   List<ProductAttributeModel>? productAttributes;
//   List<ProductVariationModel>? productVariations;
//   List<ReviewModel>? reviews;
//
//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.stock,
//     required this.price,
//     required this.thumbnail,
//     required this.productType,
//     this.sku,
//     this.date,
//     this.salePrice = 0.0,
//     this.isFeatured,
//     this.brand,
//     this.description,
//     this.categoryId,
//     this.images,
//     this.productAttributes,
//     this.productVariations,
//     this.reviews,
//   });
//
//   static ProductModel empty() => ProductModel(
//       id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: ProductType.single);
//
//   toJson() {
//     return {
//       'Title': title,
//       'Stock': stock,
//       'Price': price,
//       'Thumbnail': thumbnail,
//       'ProductType': productType,
//       'SKU': sku,
//       'Date': date,
//       'SalePrice': salePrice,
//       'IsFeatured': isFeatured,
//       'Brand': brand?.toJson(),
//       'Description': description,
//       'CategoryId': categoryId,
//       'Images': images ?? [],
//       'ProductAttributes': productAttributes != null
//           ? productAttributes!.map((e) => e.toJson()).toList()
//           : [],
//       'ProductVariations': productVariations != null
//           ? productVariations!.map((e) => e.toJson()).toList()
//           : [],
//       'Reviews': reviews != null
//           ? reviews!.map((review) => review.toJson()).toList()
//           : [],
//     };
//   }
//
//   factory ProductModel.fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> document) {
//     if (document.data() == null) return ProductModel.empty();
//     final data = document.data()!;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'],
//       title: data['Title'],
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? '0.0').toString()),
//       salePrice: double.parse((data['SalePrice'] ?? '0.0').toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: data['ProductType'] ?? '',
//       brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//               .map((e) => ProductAttributeModel.fromJson(e))
//               .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//               .map((e) => ProductVariationModel.fromJson(e))
//               .toList()
//           : [],
//       reviews: data['Reviews'] != null
//           ? (data['Reviews'] as List<dynamic>)
//               .map((e) => ReviewModel.fromJson(e))
//               .toList()
//           : [],
//     );
//   }
//
//   factory ProductModel.fromQuerySnapshot(
//       QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'] ?? '',
//       title: data['Title'] ?? '',
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? 0.0).toString()),
//       salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: data['ProductType'] ?? '',
//       brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//               .map((e) => ProductAttributeModel.fromJson(e))
//               .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//               .map((e) => ProductVariationModel.fromJson(e))
//               .toList()
//           : [],
//       reviews: data['Reviews'] != null
//           ? (data['Reviews'] as List<dynamic>)
//               .map((e) => ReviewModel.fromJson(e))
//               .toList()
//           : [],
//     );
//   }
// }


// extension ProductTypeExtension on ProductType {
//   String get name => toString().split('.').last;
//
//   static ProductType fromString(String value) {
//     try {
//       return ProductType.values.firstWhere((e) => e.name == value);
//     } catch (e) {
//       throw ArgumentError('Invalid ProductType: $value');
//     }
//   }
// }
// class ProductModel {
//   String id;
//   int stock;
//   String? sku;
//   double price;
//   String title;
//   DateTime? date;
//   double salePrice;
//   String thumbnail;
//   bool? isFeatured;
//   NewBrandModel? brand;
//   String? description;
//   String? categoryId;
//   List<String>? images;
//   ProductType productType;
//   List<ProductAttributeModel>? productAttributes;
//   List<ProductVariationModel>? productVariations;
//   List<ReviewModel>? reviews;
//
//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.stock,
//     required this.price,
//     required this.thumbnail,
//     required this.productType,
//     this.sku,
//     this.date,
//     this.salePrice = 0.0,
//     this.isFeatured,
//     this.brand,
//     this.description,
//     this.categoryId,
//     this.images,
//     this.productAttributes,
//     this.productVariations,
//     this.reviews,
//   });
//
//   static ProductModel empty() => ProductModel(
//       id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: ProductType.single);
//
//   Map<String, dynamic> toJson() {
//     return {
//       'Title': title,
//       'Stock': stock,
//       'Price': price,
//       'Thumbnail': thumbnail,
//       'ProductType': productType.name, // Store enum as string
//       'SKU': sku,
//       'Date': date,
//       'SalePrice': salePrice,
//       'IsFeatured': isFeatured,
//       'Brand': brand?.toJson(),
//       'Description': description,
//       'CategoryId': categoryId,
//       'Images': images ?? [],
//       'ProductAttributes': productAttributes != null
//           ? productAttributes!.map((e) => e.toJson()).toList()
//           : [],
//       'ProductVariations': productVariations != null
//           ? productVariations!.map((e) => e.toJson()).toList()
//           : [],
//       'Reviews': reviews != null
//           ? reviews!.map((review) => review.toJson()).toList()
//           : [],
//     };
//   }
//
//   factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     if (document.data() == null) return ProductModel.empty();
//     final data = document.data()!;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'],
//       title: data['Title'],
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? '0.0').toString()),
//       salePrice: double.parse((data['SalePrice'] ?? '0.0').toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: ProductTypeExtension.fromString(data['ProductType'] ?? 'single'), // Convert string to enum
//       brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//           .map((e) => ProductAttributeModel.fromJson(e))
//           .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//           .map((e) => ProductVariationModel.fromJson(e))
//           .toList()
//           : [],
//       reviews: data['Reviews'] != null
//           ? (data['Reviews'] as List<dynamic>)
//           .map((e) => ReviewModel.fromJson(e))
//           .toList()
//           : [],
//     );
//   }
//
//   factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'] ?? '',
//       title: data['Title'] ?? '',
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? 0.0).toString()),
//       salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: ProductTypeExtension.fromString(data['ProductType'] ?? 'single'), // Convert string to enum
//       brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//           .map((e) => ProductAttributeModel.fromJson(e))
//           .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//           .map((e) => ProductVariationModel.fromJson(e))
//           .toList()
//           : [],
//       reviews: data['Reviews'] != null
//           ? (data['Reviews'] as List<dynamic>)
//           .map((e) => ReviewModel.fromJson(e))
//           .toList()
//           : [],
//     );
//   }
// }



// extension ProductTypeExtension on ProductType {
//   String get stringValue => toString().split('.').last;
// }

// class ProductModel {
//   String id;
//   int stock;
//   String? sku;
//   double price;
//   String title;
//   DateTime? date;
//   double salePrice;
//   String thumbnail;
//   bool? isFeatured;
//   NewBrandModel? brand;
//   String? description;
//   String? categoryId;
//   List<String>? images;
//   ProductType productType;
//   List<ProductAttributeModel>? productAttributes;
//   List<ProductVariationModel>? productVariations;
//   List<ReviewModel>? reviews;
//
//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.stock,
//     required this.price,
//     required this.thumbnail,
//     required this.productType,
//     this.sku,
//     this.date,
//     this.salePrice = 0.0,
//     this.isFeatured,
//     this.brand,
//     this.description,
//     this.categoryId,
//     this.images,
//     this.productAttributes,
//     this.productVariations,
//     this.reviews,
//   });
//
//   static ProductModel empty() => ProductModel(
//     id: '',
//     title: '',
//     stock: 0,
//     price: 0,
//     thumbnail: '',
//     productType: ProductType.single,
//   );
//
//   Map<String, dynamic> toJson() {
//     return {
//       'Title': title,
//       'Stock': stock,
//       'Price': price,
//       'Thumbnail': thumbnail,
//       'ProductType': 'ProductType.${productType.stringValue}', // Store as string with prefix
//       'SKU': sku,
//       'Date': date,
//       'SalePrice': salePrice,
//       'IsFeatured': isFeatured,
//       'Brand': brand?.toJson(),
//       'Description': description,
//       'CategoryId': categoryId,
//       'Images': images ?? [],
//       'ProductAttributes': productAttributes != null
//           ? productAttributes!.map((e) => e.toJson()).toList()
//           : [],
//       'ProductVariations': productVariations != null
//           ? productVariations!.map((e) => e.toJson()).toList()
//           : [],
//       'Reviews': reviews != null ? reviews!.map((review) => review.toJson()).toList() : [],
//     };
//   }
//
//   factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
//     if (!document.exists) return ProductModel.empty();
//
//     final data = document.data()!;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'],
//       title: data['Title'],
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: (data['Price'] ?? 0.0).toDouble(),
//       salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: ProductTypeExtension.fromFirestoreString(data['ProductType']),
//       brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//           .map((e) => ProductAttributeModel.fromJson(e))
//           .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//           .map((e) => ProductVariationModel.fromJson(e))
//           .toList()
//           : [],
//       reviews: data['Reviews'] != null
//           ? (data['Reviews'] as List<dynamic>)
//           .map((e) => ReviewModel.fromJson(e))
//           .toList()
//           : [],
//     );
//   }
//
//   factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
//     final data = document.data() as Map<String, dynamic>;
//     return ProductModel(
//       id: document.id,
//       sku: data['SKU'] ?? '',
//       title: data['Title'] ?? '',
//       stock: data['Stock'] ?? 0,
//       isFeatured: data['IsFeatured'] ?? false,
//       price: double.parse((data['Price'] ?? 0.0).toString()),
//       salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
//       thumbnail: data['Thumbnail'] ?? '',
//       categoryId: data['CategoryId'] ?? '',
//       description: data['Description'] ?? '',
//       productType: _parseProductType(data['ProductType']),
//       brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
//       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
//       productAttributes: data['ProductAttributes'] != null
//           ? (data['ProductAttributes'] as List<dynamic>)
//           .map((e) => ProductAttributeModel.fromJson(e))
//           .toList()
//           : [],
//       productVariations: data['ProductVariations'] != null
//           ? (data['ProductVariations'] as List<dynamic>)
//           .map((e) => ProductVariationModel.fromJson(e))
//           .toList()
//           : [],
//       reviews: data['Reviews'] != null
//           ? (data['Reviews'] as List<dynamic>)
//           .map((e) => ReviewModel.fromJson(e))
//           .toList()
//           : [],
//     );
//   }
//
//   static ProductType _parseProductType(String value) {
//     if (value.startsWith('ProductType.')) {
//       String enumString = value.split('.').last;
//       switch (enumString) {
//         case 'single':
//           return ProductType.single;
//         case 'variable':
//           return ProductType.variable;
//         default:
//           throw ArgumentError('Invalid ProductType string: $value');
//       }
//     } else {
//       throw ArgumentError('Invalid ProductType string format: $value');
//     }
//   }
// }
//
// extension ProductTypeExtension on ProductType {
//   String toFirestoreString() {
//     return 'ProductType.${this.toString().split('.').last}';
//   }
//
//   static ProductType fromFirestoreString(String value) {
//     switch (value) {
//       case 'ProductType.single':
//         return ProductType.single;
//       case 'ProductType.variable':
//         return ProductType.variable;
//       default:
//         throw ArgumentError('Unknown ProductType string: $value');
//     }
//   }
// }

enum ProductType {
  single,
  variable
}

extension ProductTypeExtension on ProductType {
  String get stringValue => 'ProductType.${this.toString().split('.').last}';

  static ProductType fromString(String? value) {
    if (value == null || value.isEmpty) {
      print('Warning: Null or empty ProductType, defaulting to single');
      return ProductType.single;
    }

    final cleanValue = value.startsWith('ProductType.') ? value.split('.').last : value;

    switch (cleanValue.toLowerCase()) {
      case 'single':
        return ProductType.single;
      case 'variable':
        return ProductType.variable;
      default:
        print('Warning: Unknown ProductType "$value", defaulting to single');
        return ProductType.single;
    }
  }
}

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  NewBrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  ProductType productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  List<ReviewModel>? reviews;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.date,
    this.salePrice = 0.0,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    this.productAttributes,
    this.productVariations,
    this.reviews,
  });

  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: ProductType.single,
  );

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Thumbnail': thumbnail,
      'ProductType': productType.stringValue,
      'SKU': sku,
      'Date': date?.toIso8601String(),
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'Brand': brand?.toJson(),
      'Description': description,
      'CategoryId': categoryId,
      'Images': images,
      'ProductAttributes': productAttributes?.map((e) => e.toJson()).toList(),
      'ProductVariations': productVariations?.map((e) => e.toJson()).toList(),
      'Reviews': reviews?.map((review) => review.toJson()).toList(),
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (!document.exists) return ProductModel.empty();

    final data = document.data()!;
    try {
      return ProductModel(
        id: document.id,
        sku: data['SKU'],
        title: data['Title'] ?? '',
        stock: data['Stock'] ?? 0,
        isFeatured: data['IsFeatured'],
        price: (data['Price'] ?? 0.0).toDouble(),
        salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
        thumbnail: data['Thumbnail'] ?? '',
        categoryId: data['CategoryId'],
        description: data['Description'],
        productType: ProductTypeExtension.fromString(data['ProductType']),
        brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
        images: data['Images'] != null ? List<String>.from(data['Images']) : null,
        productAttributes: (data['ProductAttributes'] as List<dynamic>?)
            ?.map((e) => ProductAttributeModel.fromMap(e))
            .toList(),
        productVariations: (data['ProductVariations'] as List<dynamic>?)
            ?.map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        reviews: (data['Reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      print('Error creating ProductModel from document ${document.id}: $e');
      print('Raw data: $data');
      return ProductModel.empty();
    }
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    try {
      return ProductModel(
        id: document.id,
        sku: data['SKU'],
        title: data['Title'] ?? '',
        stock: data['Stock'] ?? 0,
        isFeatured: data['IsFeatured'],
        price: double.parse((data['Price'] ?? 0.0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        thumbnail: data['Thumbnail'] ?? '',
        categoryId: data['CategoryId'],
        description: data['Description'],
        productType: ProductTypeExtension.fromString(data['ProductType']),
        brand: data['Brand'] != null ? NewBrandModel.fromJson(data['Brand']) : null,
        images: data['Images'] != null ? List<String>.from(data['Images']) : null,
        productAttributes: (data['ProductAttributes'] as List<dynamic>?)
            ?.map((e) => ProductAttributeModel.fromJson(e))
            .toList(),
        productVariations: (data['ProductVariations'] as List<dynamic>?)
            ?.map((e) => ProductVariationModel.fromJson(e))
            .toList(),
        reviews: (data['Reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e))
            .toList(),
      );
    } catch (e) {
      print('Error creating ProductModel from query document ${document.id}: $e');
      print('Raw data: $data');
      return ProductModel.empty();
    }
  }
}
