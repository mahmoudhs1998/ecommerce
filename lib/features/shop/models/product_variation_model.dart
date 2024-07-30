class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku='',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues
  });

  /// Create Empty Method for clean code
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  /// json format
  toJson(){
    return {
      'Id': id,
     'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
     'SalePrice': salePrice,
     'Stock': stock,
      'AttributeValues': attributeValues
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
        id: data['Id'] ?? '',
        price: double.parse((data['Price'] ?? 0.0).toString()),
    sku: data['SKU'] ?? '',
    stock: data['Stock'] ?? 0,
    salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
    description: data['Description'] ?? '',

    image: data['Image'] ??'',
    attributeValues: Map<String, String>. from(data[ 'AttributeValues']),
    ); // ProductVariationModel
  }


  ProductVariationModel copyWith({
    String? id,
    int? stock,
    double? price,
    double? salePrice,
    String? image,
    String? description,
    Map<String, String>? attributeValues,
  }) {
    return ProductVariationModel(
      id: id ?? this.id,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      image: image ?? this.image,
      description: description ?? this.description,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }

  factory ProductVariationModel.fromMap(Map<String, dynamic> map) {
    final data = map;
    if(data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      attributeValues: Map<String, String>.from(map['AttributeValues'] as Map),
      stock: map['Stock'] as int,
      sku: map['SKU'] as String,
      price: _parseDouble(map['Price']),
      description: map['Description'] as String,
      salePrice: _parseDouble(map['SalePrice']),
      image: map['Image'] as String, id:data['Id'] ?? '',
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }
}