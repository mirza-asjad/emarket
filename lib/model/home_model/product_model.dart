// class ProductModel {
//   int? id;
//   String? title;
//   int? price;
//   String? description;
//   List<String>? images;
//   String? creationAt;
//   String? updatedAt;
//   Category? category;

//   ProductModel({
//     this.id,
//     this.title,
//     this.price,
//     this.description,
//     this.images,
//     this.creationAt,
//     this.updatedAt,
//     this.category,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'price': price,
//       'description': description,
//       'images': images?.join(','),
//       'creationAt': creationAt,
//       'updatedAt': updatedAt,
//       'categoryId': category?.id,
//     };
//   }

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? 0;
//     title = json['title'] ?? '';
//     price = json['price'] ?? 0;
//     description = json['description'] ?? '';
//     images = json['images'] != null ? List<String>.from(json['images']) : [];
//     creationAt = json['creationAt'] ?? '';
//     updatedAt = json['updatedAt'] ?? '';
//     category =
//         json['category'] != null ? Category.fromJson(json['category']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['price'] = price;
//     data['description'] = description;
//     data['images'] = images;
//     data['creationAt'] = creationAt;
//     data['updatedAt'] = updatedAt;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     return data;
//   }
// }

// class Category {
//   int? id;
//   String? name;
//   String? image;
//   String? creationAt;
//   String? updatedAt;

//   Category({this.id, this.name, this.image, this.creationAt, this.updatedAt});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'creationAt': creationAt,
//       'updatedAt': updatedAt,
//     };
//   }

//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? 0;
//     name = json['name'] ?? '';
//     image = json['image'] ?? '';
//     creationAt = json['creationAt'] ?? '';
//     updatedAt = json['updatedAt'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['image'] = image;
//     data['creationAt'] = creationAt;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
// }

class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  Category? category;
  late bool isFav;
  late bool isCart;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.category,
    this.isFav = false, // Default value is false
    this.isCart = false, // Default value is false
  });

  ProductModel copyWith({
    int? id,
    String? title,
    int? price,
    String? description,
    List<String>? images,
    String? creationAt,
    String? updatedAt,
    Category? category,
    bool? isFav,
    bool? isCart,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      isFav: isFav ?? this.isFav,
      isCart: isCart ?? this.isCart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images?.join(','),
      'creationAt': creationAt,
      'updatedAt': updatedAt,
      'categoryId': category?.id,
      'isFav': isFav ? 1 : 0, // Convert bool to int (1 or 0)
      'isCart': isCart ? 1 : 0, // Convert bool to int (1 or 0)
    };
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    price = json['price'] ?? 0;
    description = json['description'] ?? '';
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    creationAt = json['creationAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    isFav = json['isFav'] ?? false;
    isCart = json['isCart'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['images'] = images;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['isFav'] = isFav;
    data['isCart'] = isCart;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? creationAt;
  String? updatedAt;

  Category({this.id, this.name, this.image, this.creationAt, this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    creationAt = json['creationAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
