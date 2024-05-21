// import 'dart:async';

// import 'package:emarket/model/home_model/product_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   static const String _tableName = 'products';
//   static const String _categoryTableName = 'categories';

//   static Database? _database;

//   DatabaseHelper._privateConstructor();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await initDatabase();
//     return _database!;
//   }

//   Future<Database> initDatabase() async {
//     final path = await getDatabasesPath();
//     final databasePath = join(path, 'emarket.db');

//     return openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE $_tableName(
//             id INTEGER PRIMARY KEY,
//             title TEXT,
//             price INTEGER,
//             description TEXT,
//             images TEXT,
//             creationAt TEXT,
//             updatedAt TEXT,
//             categoryId INTEGER
//           )
//         ''');
//         await db.execute('''
//           CREATE TABLE $_categoryTableName(
//             id INTEGER PRIMARY KEY,
//             name TEXT,
//             image TEXT,
//             creationAt TEXT,
//             updatedAt TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertProduct(ProductModel product) async {
//     final db = await database;
//     return await db.insert(_tableName, product.toMap());
//   }

//   Future<int> insertCategory(Category category) async {
//     final db = await database;
//     return await db.insert(_categoryTableName, category.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<ProductModel>> getAllProducts() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(_tableName);
//     return List.generate(maps.length, (i) {
//       return ProductModel(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         price: maps[i]['price'],
//         description: maps[i]['description'],
//         images: maps[i]['images']?.split(',')?.toList(),
//         creationAt: maps[i]['creationAt'],
//         updatedAt: maps[i]['updatedAt'],
//         category: Category(
//           id: maps[i]['categoryId'],
//           name: '',
//           image: '',
//           creationAt: '',
//           updatedAt: '',
//         ),
//       );
//     });
//   }

//   Future<List<Category>> getAllCategories() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(_categoryTableName);
//     return List.generate(maps.length, (i) {
//       return Category(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         image: maps[i]['image'],
//         creationAt: maps[i]['creationAt'],
//         updatedAt: maps[i]['updatedAt'],
//       );
//     });
//   }

//   Future<List<ProductModel>> getProductsByCategoryId(int categoryId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       _tableName,
//       where: 'categoryId = ?',
//       whereArgs: [categoryId],
//     );

//     return List.generate(maps.length, (i) {
//       return ProductModel(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         price: maps[i]['price'],
//         description: maps[i]['description'],
//         images: maps[i]['images']?.split(',')?.toList() ?? [],
//         creationAt: maps[i]['creationAt'],
//         updatedAt: maps[i]['updatedAt'],
//         category: Category(
//           id: maps[i]['categoryId'],
//           name: '', // Fetch the category name separately if needed
//           image: '',
//           creationAt: '',
//           updatedAt: '',
//         ),
//       );
//     });
//   }

//   Future<List<ProductModel>> getRandomProducts(int limit) async {
//   final db = await database;
//   final List<Map<String, dynamic>> maps = await db.rawQuery(
//     'SELECT * FROM $_tableName ORDER BY RANDOM() LIMIT ?',
//     [limit],
//   );

//   return List.generate(maps.length, (i) {
//     return ProductModel(
//       id: maps[i]['id'],
//       title: maps[i]['title'],
//       price: maps[i]['price'],
//       description: maps[i]['description'],
//       images: maps[i]['images']?.split(',')?.toList() ?? [],
//       creationAt: maps[i]['creationAt'],
//       updatedAt: maps[i]['updatedAt'],
//       category: Category(
//         id: maps[i]['categoryId'],
//         name: '', // Fetch the category name separately if needed
//         image: '',
//         creationAt: '',
//         updatedAt: '',
//       ),
//     );
//   });
// }

// }

import 'dart:async';

import 'package:emarket/model/home_model/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const String _tableName = 'products';
  static const String _categoryTableName = 'categories';

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'emarket.db');

    return openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY,
            title TEXT,
            price INTEGER,
            description TEXT,
            images TEXT,
            creationAt TEXT,
            updatedAt TEXT,
            categoryId INTEGER,
            isFav BOOL,
            isCart BOOL
          )
        ''');
        await db.execute('''
          CREATE TABLE $_categoryTableName(
            id INTEGER PRIMARY KEY,
            name TEXT,
            image TEXT,
            creationAt TEXT,
            updatedAt TEXT
          )
        ''');
      },
    );
  }

  Future<void> removeAllProductsFromCart() async {
    final db = await database;
    await db.update(
      _tableName,
      {'isCart': 0},
      where: 'isCart = ?',
      whereArgs: [1], // 1 for true
    );
  }

  Future<int> getCartItemCount() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(id) as count FROM $_tableName WHERE isCart = ?',
      [1], // 1 for true
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getFavItemCount() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(id) as count FROM $_tableName WHERE isFav = ?',
      [1], // 1 for true
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> removeProductFromCart(int productId) async {
    final db = await database;
    return await db.update(
      _tableName,
      {'isCart': 0},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  StreamController<int> _totalCartPriceController =
      StreamController<int>.broadcast();

  Stream<int> get totalCartPriceStream => _totalCartPriceController.stream;

  Stream<int> getTotalCartPriceStream() {
    updateTotalCartPrice();
    return _totalCartPriceController.stream;
  }

  void updateTotalCartPrice() async {
    while (true) {
      final List<ProductModel> products = await getAllCartProducts();
      int totalPrice = 0;
      for (final product in products) {
        totalPrice += product.price!;
      }
      _totalCartPriceController.add(totalPrice);
      await Future.delayed(const Duration(seconds: 1)); // Update every second
    }
  }

  Future<List<ProductModel>> getAllCartProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isCart = ?',
      whereArgs: [1], // 1 for true
    );

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        images: maps[i]['images']?.split(',')?.toList() ?? [],
        creationAt: maps[i]['creationAt'],
        updatedAt: maps[i]['updatedAt'],
        category: Category(
          id: maps[i]['categoryId'],
          name: '', // Fetch the category name separately if needed
          image: '',
          creationAt: '',
          updatedAt: '',
        ),
        isFav: maps[i]['isFav'] == 1, // Convert int (0 or 1) to bool
        isCart: maps[i]['isCart'] == 1, // Convert int (0 or 1) to bool
      );
    });
  }

  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    final Map<String, dynamic> productMap = product.toMap();
    return await db.insert(_tableName, productMap);
  }

  Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert(_categoryTableName, category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        images: maps[i]['images']?.split(',')?.toList(),
        creationAt: maps[i]['creationAt'],
        updatedAt: maps[i]['updatedAt'],
        category: Category(
          id: maps[i]['categoryId'],
          name: '',
          image: '',
          creationAt: '',
          updatedAt: '',
        ),
        isFav: maps[i]['isFav'] == 1, // Convert int (0 or 1) to bool
        isCart: maps[i]['isCart'] == 1, // Convert int (0 or 1) to bool
      );
    });
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_categoryTableName);
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
        image: maps[i]['image'],
        creationAt: maps[i]['creationAt'],
        updatedAt: maps[i]['updatedAt'],
      );
    });
  }

  Future<List<ProductModel>> getProductsByCategoryId(int categoryId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        images: maps[i]['images']?.split(',')?.toList() ?? [],
        creationAt: maps[i]['creationAt'],
        updatedAt: maps[i]['updatedAt'],
        category: Category(
          id: maps[i]['categoryId'],
          name: '', // Fetch the category name separately if needed
          image: '',
          creationAt: '',
          updatedAt: '',
        ),
        isFav: maps[i]['isFav'] == 1, // Convert int (0 or 1) to bool
        isCart: maps[i]['isCart'] == 1, // Convert int (0 or 1) to bool
      );
    });
  }

  Future<int> updateProduct(ProductModel product) async {
    final db = await database;
    return await db.update(
      _tableName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> updateProductIsCart(int productId, bool isCart) async {
    final db = await database;
    return await db.update(
      _tableName,
      {'isCart': isCart ? 1 : 0},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isFav = ?',
      whereArgs: [1], // 1 for true
    );

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        images: maps[i]['images']?.split(',')?.toList() ?? [],
        creationAt: maps[i]['creationAt'],
        updatedAt: maps[i]['updatedAt'],
        category: Category(
          id: maps[i]['categoryId'],
          name: '', // Fetch the category name separately if needed
          image: '',
          creationAt: '',
          updatedAt: '',
        ),
        isFav: maps[i]['isFav'] == 1, // Convert int (0 or 1) to bool
        isCart: maps[i]['isCart'] == 1, // Convert int (0 or 1) to bool
      );
    });
  }

  // Don't forget to close the stream controller when no longer needed
  void dispose() {
    _totalCartPriceController.close();
  }

  Future<List<ProductModel>> getRandomProducts(int limit) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM $_tableName ORDER BY RANDOM() LIMIT ?',
      [limit],
    );

    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        images: maps[i]['images']?.split(',')?.toList() ?? [],
        creationAt: maps[i]['creationAt'],
        updatedAt: maps[i]['updatedAt'],
        category: Category(
          id: maps[i]['categoryId'],
          name: '', // Fetch the category name separately if needed
          image: '',
          creationAt: '',
          updatedAt: '',
        ),
        isFav: maps[i]['isFav'] == 1, // Convert int (0 or 1) to bool
        isCart: maps[i]['isCart'] == 1, // Convert int (0 or 1) to bool
      );
    });
  }

  Future<bool> checkIfProductIsInCart(int productId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'id = ? AND isCart = ?',
      whereArgs: [productId, 1], // 1 for true
      limit:
          1, // Limit the result to 1 as we only need to check if the product exists
    );

    return result
        .isNotEmpty; // Return true if the result is not empty (product is in cart)
  }
}
