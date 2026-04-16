class ProductModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
  final double? ratingRate;
  final int? ratingCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    this.ratingRate,
    this.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rating = json['rating'] as Map<String, dynamic>?;

    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price']).toDouble(),
      image: json['image'],
      description: json['description'],
      category: json['category'],
      ratingRate: (rating?['rate'] as num?)?.toDouble(),
      ratingCount: rating?['count'] as int?,
    );
  }
}