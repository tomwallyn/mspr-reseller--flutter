class Product {
  Product({
    required this.label,
    required this.description,
    required this.price,
    required this.url,
    required this.date_creation,
    required this.ref,
    required this.stock_reel,
  });

  String label;
  String description;
  double price;
  String? url;
  String date_creation;
  String ref;
  int? stock_reel;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        label: json['label'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        url: json['url'] as String?,
        date_creation: json['date_creation'] as String,
        ref: json['ref'] as String,
        stock_reel: json['stock_reel'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "description": description,
        "price": price,
        "url": url,
        "date_creation": date_creation,
        "ref": ref,
        "stock_reel": stock_reel,
      };
}
