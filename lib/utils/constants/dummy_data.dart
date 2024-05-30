import 'package:ecommerce/utils/constants/images.dart';

import '../../features/shop/models/category_model.dart';

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

}