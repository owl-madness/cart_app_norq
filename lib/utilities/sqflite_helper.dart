import 'package:cart_app_norq/home/model/product_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
        CREATE TABLE product_table (
          id INTEGER,
          title TEXT,
          price REAL,
          description TEXT,
          rating REAL,
          image TEXT,
           category TEXT,
          quantity INTEGER,
          ratingCount INTEGER
        )
      ''');
  }

  Future<int> insert(ProductData product) async {
    Map<String, dynamic> row = {
      "id": product.id,
      "title": product.title,
      "price": product.price,
      "description": product.description,
      "rating": product.rating?.rate,
      "category": product.category,
      "image": product.image,
      "ratingCount": product.rating?.count,
      "quantity": product.quantity
    };
    Database? db = await database;
    return await db!.insert('product_table', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await database;
    return await db!.query('product_table');
  }

  Future<int> update(ProductData product) async {
    Map<String, dynamic> row = {
      "id": product.id,
      "title": product.title,
      "price": product.price,
      "description": product.description,
      "rating": product.rating?.rate,
      "category": product.category,
      "image": product.image,
      "ratingCount": product.rating?.count,
      "quantity": product.quantity
    };
    Database? db = await database;
    int id = row['id'];
    return await db!
        .update('product_table', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await database;
    return await db!.delete('product_table', where: 'id = ?', whereArgs: [id]);
  }
}
