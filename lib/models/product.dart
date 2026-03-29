class Product {
  final int? id; // Es opcional porque al crear un producto nuevo (POST), nosotros no le enviamos ID, la API lo genera.
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double? rating; // La calificación

  Product({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  // Este método traduce el JSON de internet a nuestro objeto Dart (GET)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      // Usamos .toDouble() porque a veces la API envía un 100 (int) en lugar de 100.0 (double) y eso da error en Flutter.
      price: json['price']?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      // FakeStore envía el rating como un objeto {rate: 3.9, count: 120}. Sacamos solo el 'rate'.
      rating: json['rating'] != null ? json['rating']['rate']?.toDouble() : 0.0,
    );
  }

  // Este método traduce nuestro objeto Dart a JSON para enviarlo a internet (POST)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      // No incluimos el ID ni el rating porque esos datos los controla la base de datos de la API, no nosotros.
    };
  }
}