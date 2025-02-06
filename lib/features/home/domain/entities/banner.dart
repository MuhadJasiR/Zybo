class Banners {
  final int id;
  final String imageUrl;

  Banners({required this.id, required this.imageUrl});

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json["id"],
      imageUrl: json["image"],
    );
  }
}
