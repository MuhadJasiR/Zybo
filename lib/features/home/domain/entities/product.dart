class Product {
  final int id;
  final String name;
  final List imageUrl;
  final int price;
  final int oldPrice;
  final int rating;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.rating,
  });

  Product copyWith({bool? inWishlist}) {
    return Product(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      oldPrice: oldPrice,
      rating: rating,
    );
  }
}
