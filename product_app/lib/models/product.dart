class Product {
  final int? id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
  final double? ratingRate;
  final int? ratingCount;

  Product({
    this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    this.ratingRate,
    this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      ratingRate: (json['rating']?['rate'] as num?)?.toDouble(),
      ratingCount: json['rating']?['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
      if (ratingRate != null || ratingCount != null)
        'rating': {
          if (ratingRate != null) 'rate': ratingRate,
          if (ratingCount != null) 'count': ratingCount,
        },
    };
  }

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? image,
    String? description,
    String? category,
    double? ratingRate,
    int? ratingCount,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      ratingRate: ratingRate ?? this.ratingRate,
      ratingCount: ratingCount ?? this.ratingCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ price.hashCode;
}
