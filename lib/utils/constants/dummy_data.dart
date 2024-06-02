import 'package:ecommerce/utils/constants/images.dart';

import '../../features/shop/models/banner_model.dart';
import '../../features/shop/models/brand_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../features/shop/models/product_attribute_model.dart';
import '../../features/shop/models/product_model.dart';
import '../../features/shop/models/product_variation_model.dart';
import '../../routes/routes.dart';

class TDummyData
{
   TDummyData._();

/// -- List of All Categories
static final List<CategoryModel> categories = [
  CategoryModel(id: '1', name: 'Sports', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '5', name: 'Furniture', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '2', name: 'Electronics', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '3', name: 'Clothes', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '4', name: 'Animals', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '6', name: 'Shoes', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '7', name: 'Cosmetics', image: TImages.category1, isFeatured: true),
  CategoryModel(id: '14', name: 'Jewelery', image: TImages.category1, isFeatured: true),

  // -- Sub Categories
  CategoryModel(id: '8', name: 'Sports Shoes', image: TImages.category1, parentId: '1', isFeatured: false),
  CategoryModel(id: '9', name: 'Track Suits', image: TImages.category1, parentId: '1', isFeatured: false),
  CategoryModel(id: '10', name: 'Sports Equipments', image: TImages.category1, parentId: '1', isFeatured: false),

  // -- Furniture
  CategoryModel(id: '11', name: 'Bedroom Furniture', image: TImages.category1, parentId: '5', isFeatured: false),
  CategoryModel(id: '12', name: 'Kitchen Furniture', image: TImages.category1, parentId: '5', isFeatured: false),
  CategoryModel(id: '13', name: 'Office Furniture', image: TImages.category1, parentId: '5', isFeatured: false),

  // -- Electronics
  CategoryModel(id: '14', name: 'Laptop', image: TImages.category1, parentId: '2', isFeatured: false),
  CategoryModel(id: '15', name: 'Mobile', image: TImages.category1, parentId: '2', isFeatured: false),


  CategoryModel(id: '16', name: 'Shirts', image: TImages.category1, parentId: '3', isFeatured: false),




];

   /// -- Banners
   static final List<BannerModel> banners = [
   BannerModel(imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
   BannerModel(imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
   BannerModel(imageUrl: TImages.banner3, targetScreen: TRoutes.favourites, active: true),
   BannerModel(imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
   BannerModel(imageUrl: TImages.banner5, targetScreen: TRoutes.settings, active: true),
   BannerModel(imageUrl: TImages.banner1, targetScreen: TRoutes.userAddress, active: true),
   BannerModel(imageUrl: TImages.banner4, targetScreen: TRoutes.checkout, active: false),
];


   /// -- List of All Products --
   static final List<ProductModel> products =[
     ProductModel (
       id: '001',
       title: 'Green Nike sports shoe',
       stock: 15,
       price: 135,
       isFeatured: true,
       thumbnail: TImages.category1,
       description: 'Green Nike sports shoe',
       brand: BrandModel(id: '1', image: TImages.facebook, name: 'Nike', productsCount: 265, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 30,
       sku: 'ABR4568',
       categoryId: '1',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '1',
             stock: 34,
             price: 134,
             salePrice: 122.6,
             image: TImages.banner4,
             description: 'This is a Product description for Green Nike sports shoe.',
             attributeValues: {'Color': 'Green', 'Size': 'EU 34'}
         ), // ProductVariat
         ProductVariationModel(
             id: '2',
             stock: 35,
             price: 164,
             salePrice: 162.6,
             image: TImages.banner4,
             description: 'This is a Product description for Green Nike sports shoe.',
             attributeValues: {'Color': 'Red', 'Size': 'EU 36'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel (
       id: '002',
       title: 'Red Adidas sports shoe',
       stock: 10,
       price: 120,
       isFeatured: false,
       thumbnail: TImages.category1,
       description: 'Red Adidas sports shoe',
       brand: BrandModel(id: '2', image: TImages.google, name: 'Adidas', productsCount: 185, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 20,
       sku: 'XYZ1234',
       categoryId: '2',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Red', 'Black', 'White' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 32', 'EU 34', 'EU 36']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '3',
             stock: 24,
             price: 114,
             salePrice: 102.6,
             image: TImages.banner5,
             description: 'This is a Product description for Red Adidas sports shoe.',
             attributeValues: {'Color': 'Red', 'Size': 'EU 34'}
         ), // ProductVariat
         ProductVariationModel(
             id: '4',
             stock: 25,
             price: 144,
             salePrice: 142.6,
             image: TImages.banner5,
             description: 'This is a Product description for Red Adidas sports shoe.',
             attributeValues: {'Color': 'White', 'Size': 'EU 36'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '003',
       title: 'Blue Puma sports shoe',
       stock: 20,
       price: 140,
       isFeatured: true,
       thumbnail: TImages.category1,
       description: 'Blue Puma sports shoe',
       brand: BrandModel(id: '3', image: TImages.facebook, name: 'Puma', productsCount: 350, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 10,
       sku: 'PQR9876',
       categoryId: '3',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Blue', 'White', 'Black' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 34', 'EU 36', 'EU 38']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '5',
             stock: 14,
             price: 134,
             salePrice: 122.6,
             image: TImages.banner3,
             description: 'This is a Product description for Blue Puma sports shoe.',
             attributeValues: {'Color': 'Blue', 'Size': 'EU 36'}
         ), // ProductVariat
         ProductVariationModel(
             id: '6',
             stock: 15,
             price: 154,
             salePrice: 142.6,
             image: TImages.banner4,
             description: 'This is a Product description for Blue Puma sports shoe.',
             attributeValues: {'Color': 'Black', 'Size': 'EU 38'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel (
       id: '004',
       title: 'Black Reebok sports shoe',
       stock: 5,
       price: 110,
       isFeatured: false,
       thumbnail: TImages.category1,
       description: 'Black Reebok sports shoe',
       brand: BrandModel(id: '4', image: TImages.facebook, name: 'Reebok', productsCount: 200, isFeatured: false),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 5,
       sku: 'LMN5678',
       categoryId: '4',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Black', 'White', 'Gray' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '7',
             stock: 14,
             price: 104,
             salePrice: 92.6,
             image: TImages.banner2,
             description: 'This is a Product description for Black Reebok sports shoe.',
             attributeValues: {'Color': 'Black', 'Size': 'EU 32'}
         ), // ProductVariat
         ProductVariationModel(
             id: '8',
             stock: 15,
             price: 124,
             salePrice: 112.6,
             image: TImages.banner5,
             description: 'This is a Product description for Black Reebok sports shoe.',
             attributeValues: {'Color': 'Gray', 'Size': 'EU 34'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel (
       id: '005',
       title: 'White Converse sports shoe',
       stock: 18,
       price: 90,
       isFeatured: true,
       thumbnail: TImages.category1,
       description: 'White Converse sports shoe',
       brand: BrandModel(id: '5', image: TImages.facebook, name: 'Converse', productsCount: 250, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 15,
       sku: 'OPQ7890',
       categoryId: '5',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['White', 'Black', 'Red' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 32', 'EU 34', 'EU 36']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '9',
             stock: 14,
             price: 84,
             salePrice: 72.6,
             image: TImages.banner5,
             description: 'This is a Product description for White Converse sports shoe.',
             attributeValues: {'Color': 'White', 'Size': 'EU 34'}
         ), // ProductVariat
         ProductVariationModel(
             id: '10',
             stock: 15,
             price: 94,
             salePrice: 82.6,
             image: TImages.banner3,
             description: 'This is a Product description for White Converse sports shoe.',
             attributeValues: {'Color': 'Black', 'Size': 'EU 36'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '006',
       title: 'Yellow Vans sports shoe',
       stock: 12,
       price: 100,
       isFeatured: false,
       thumbnail: TImages.category1,
       description: 'Yellow Vans sports shoe',
       brand: BrandModel(id: '6', image: TImages.facebook, name: 'Vans', productsCount: 150, isFeatured: false),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 10,
       sku: 'RST3456',
       categoryId: '6',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Yellow', 'Black', 'White' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '11',
             stock: 14,
             price: 94,
             salePrice: 82.6,
             image: TImages.banner4,
             description: 'This is a Product description for Yellow Vans sports shoe.',
             attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'}
         ), // ProductVariat
         ProductVariationModel(
             id: '12',
             stock: 15,
             price: 104,
             salePrice: 92.6,
             image: TImages.banner2,
             description: 'This is a Product description for Yellow Vans sports shoe.',
             attributeValues: {'Color': 'White', 'Size': 'EU 34'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '007',
       title: 'Brown Timberland boots',
       stock: 22,
       price: 180,
       isFeatured: true,
       thumbnail: TImages.category1,
       description: 'Brown Timberland boots',
       brand: BrandModel(id: '7', image: TImages.facebook, name: 'Timberland', productsCount: 250, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 35,
       sku: 'UVW4567',
       categoryId: '7',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Brown', 'Black', 'Gray' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 38', 'EU 40', 'EU 42']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '13',
             stock: 14,
             price: 174,
             salePrice: 142.6,
             image: TImages.banner1,
             description: 'This is a Product description for Brown Timberland boots.',
             attributeValues: {'Color': 'Brown', 'Size': 'EU 40'}
         ), // ProductVariat
         ProductVariationModel(
             id: '14',
             stock: 15,
             price: 184,
             salePrice: 152.6,
             image: TImages.banner2,
             description: 'This is a Product description for Brown Timberland boots.',
             attributeValues: {'Color': 'Black', 'Size': 'EU 42'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel (
       id: '008',
       title: 'Beige Clarks boots',
       stock: 16,
       price: 160,
       isFeatured: false,
       thumbnail: TImages.category1,
       description: 'Beige Clarks boots',
       brand: BrandModel(id: '8', image: TImages.facebook, name: 'Clarks', productsCount: 210, isFeatured: false),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 25,
       sku: 'XYZ9876',
       categoryId: '8',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Beige', 'Black', 'Brown' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 36', 'EU 38', 'EU 40']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '15',
             stock: 14,
             price: 154,
             salePrice: 122.6,
             image: TImages.banner1,
             description: 'This is a Product description for Beige Clarks boots.',
             attributeValues: {'Color': 'Beige', 'Size': 'EU 38'}
         ), // ProductVariat
         ProductVariationModel(
             id: '16',
             stock: 15,
             price: 164,
             salePrice: 132.6,
             image: TImages.banner1,
             description: 'This is a Product description for Beige Clarks boots.',
             attributeValues: {'Color': 'Black', 'Size': 'EU 40'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '009',
       title: 'Black Dr. Martens boots',
       stock: 25,
       price: 145,
       isFeatured: true,
       thumbnail: TImages.category1,
       description: 'Black Dr. Martens boots',
       brand: BrandModel(id: '9', image: TImages.facebook, name: 'Dr. Martens', productsCount: 180, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 15,
       sku: 'LMN1234',
       categoryId: '9',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Black', 'Brown', 'Red' ]),
         ProductAttributeModel(name: 'Size', values: ['EU 38', 'EU 40', 'EU 42']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '17',
             stock: 14,
             price: 134,
             salePrice: 112.6,
             image: TImages.banner2,
             description: 'This is a Product description for Black Dr. Martens boots.',
             attributeValues: {'Color': 'Black', 'Size': 'EU 40'}
         ), // ProductVariat
         ProductVariationModel(
             id: '18',
             stock: 15,
             price: 144,
             salePrice: 122.6,
             image: TImages.banner2,
             description: 'This is a Product description for Black Dr. Martens boots.',
             attributeValues: {'Color': 'Brown', 'Size': 'EU 42'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '010',
       title: 'Blue Lacoste polo shirt',
       stock: 10,
       price: 70,
       isFeatured: false,
       thumbnail: TImages.category1,
       description: 'Blue Lacoste polo shirt',
       brand: BrandModel(id: '10', image: TImages.facebook, name: 'Lacoste', productsCount: 120, isFeatured: false),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 10,
       sku: 'OPQ3456',
       categoryId: '10',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Blue', 'White', 'Black' ]),
         ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '19',
             stock: 14,
             price: 64,
             salePrice: 52.6,
             image: TImages.banner1,
             description: 'This is a Product description for Blue Lacoste polo shirt.',
             attributeValues: {'Color': 'Blue', 'Size': 'M'}
         ), // ProductVariat
         ProductVariationModel(
             id: '20',
             stock: 15,
             price: 74,
             salePrice: 62.6,
             image: TImages.banner1,
             description: 'This is a Product description for Blue Lacoste polo shirt.',
             attributeValues: {'Color': 'Black', 'Size': 'L'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '011',
       title: 'White Ralph Lauren polo shirt',
       stock: 15,
       price: 80,
       isFeatured: true,
       thumbnail: TImages.category1,
       description: 'White Ralph Lauren polo shirt',
       brand: BrandModel(id: '11', image: TImages.facebook, name: 'Ralph Lauren', productsCount: 150, isFeatured: true),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 15,
       sku: 'RST7890',
       categoryId: '11',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['White', 'Blue', 'Red' ]),
         ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '21',
             stock: 14,
             price: 74,
             salePrice: 62.6,
             image: TImages.banner2,
             description: 'This is a Product description for White Ralph Lauren polo shirt.',
             attributeValues: {'Color': 'White', 'Size': 'M'}
         ), // ProductVariat
         ProductVariationModel(
             id: '22',
             stock: 15,
             price: 84,
             salePrice: 72.6,
             image: TImages.banner2,
             description: 'This is a Product description for White Ralph Lauren polo shirt.',
             attributeValues: {'Color': 'Blue', 'Size': 'L'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
     ProductModel(
       id: '012',
       title: 'Black Tommy Hilfiger polo shirt',
       stock: 8,
       price: 65,
       isFeatured: false,
       thumbnail: TImages.category1,
       description: 'Black Tommy Hilfiger polo shirt',
       brand: BrandModel(id: '12', image: TImages.facebook, name: 'Tommy Hilfiger', productsCount: 100, isFeatured: false),
       images: [TImages.category1, TImages.category1, TImages.category1, TImages.category1],
       salePrice: 5,
       sku: 'UVW1234',
       categoryId: '12',
       productAttributes: [
         ProductAttributeModel(name: 'Color', values: ['Black', 'White', 'Blue' ]),
         ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
       ],
       productVariations: [
         ProductVariationModel(
             id: '23',
             stock: 14,
             price: 60,
             salePrice: 48.6,
             image: TImages.banner3,
             description: 'This is a Product description for Black Tommy Hilfiger polo shirt.',
             attributeValues: {'Color': 'Black', 'Size': 'M'}
         ), // ProductVariat
         ProductVariationModel(
             id: '24',
             stock: 15,
             price: 68,
             salePrice: 56.6,
             image: TImages.banner3,
             description: 'This is a Product description for Black Tommy Hilfiger polo shirt.',
             attributeValues: {'Color': 'White', 'Size': 'L'}
         ),
       ],
       productType: 'ProductType.variable',
     ),
   ];

}