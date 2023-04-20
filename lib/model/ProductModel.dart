class ProductModel {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  ProductModel({this.products, this.total, this.skip, this.limit});

  fromJson(Map<String, dynamic> json) {
    products = json["products"] == null
        ? null
        : (json["products"] as List).map((e) => Products.fromJson(e)).toList();
    total = json["total"];
    skip = json["skip"];
    limit = json["limit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (products != null) {
      _data["products"] = products?.map((e) => e.toJson()).toList();
    }
    _data["total"] = total;
    _data["skip"] = skip;
    _data["limit"] = limit;
    return _data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    price = json["price"];
    discountPercentage = json["discountPercentage"];
    rating = json["rating"];
    stock = json["stock"];
    brand = json["brand"];
    category = json["category"];
    thumbnail = json["thumbnail"];
    images = json["images"] == null ? null : List<String>.from(json["images"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["price"] = price;
    _data["discountPercentage"] = discountPercentage;
    _data["rating"] = rating;
    _data["stock"] = stock;
    _data["brand"] = brand;
    _data["category"] = category;
    _data["thumbnail"] = thumbnail;
    if (images != null) {
      _data["images"] = images;
    }
    return _data;
  }
}
