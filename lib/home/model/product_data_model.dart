class ProductData {
    int? id;
    String? title;
    double? price;
    String? description;
    String? image;
    String? category;
    Rating? rating;
    int quantity;

    ProductData({
        this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating,
        this.quantity = 1
    });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    );

    factory ProductData.fromDBJson(Map<String, dynamic> dbJson) => ProductData(
        id: dbJson["id"],
        title: dbJson["title"],
        price: dbJson["price"]?.toDouble(),
        description: dbJson["description"],
        category: dbJson["category"],
        image: dbJson["image"],
        quantity: dbJson["quantity"],
        rating: Rating(count: dbJson["ratingCount"],rate: dbJson["rating"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
    };
}

class Rating {
    double? rate;
    int? count;

    Rating({
        this.rate,
        this.count,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
    };
}
