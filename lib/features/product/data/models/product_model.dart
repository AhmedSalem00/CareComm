class Product {
  final int? id;
  final String? title;
  final String? image;
  final double? price;
  final String? description;
  final String? category;
  final Rating? rating;

  Product({
    this.id,
    this.title,
    this.image,
    this.price,
    this.description,
    this.category,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price']?.toDouble(),
      description: json['description'],
      category: json['category'],
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'category': category,
      'rating': rating?.toJson(),
    };
  }
}
class Rating {
  final double rate;
  final int count;

  Rating({this.rate = 0.0, this.count = 0});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate']?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
