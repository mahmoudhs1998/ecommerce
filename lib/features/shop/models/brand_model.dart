

class BrandModel
{
  final String id;
  final String name;
  final String image;
  int? productsCount;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image ,
    this.productsCount,
    this.isFeatured
  });

  // -- Empty Helper Method
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you con store data in Firebase
  toJson() {
    return {
    'Id': id,
    'Name': name,
    'Image':image,
    'ProductsCount': productsCount,
    'IsFeatured': isFeatured,
    };
  }

   // -- Map json oriented document snapshot from Firebase to User model
factory BrandModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id']?? '',
      name: data['Name']??'',
      image: data['Image']?? '',
      productsCount: data['ProductsCount']?? '',
      isFeatured: data['IsFeatured']?? false,
    );

  }


}