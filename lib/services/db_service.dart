import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sql_test_task/logic/models/order.dart';
import 'package:sql_test_task/logic/models/product.dart';

class DatabaseService {
  static const int _version = 1;
  static const String _dbName = 'restaurant.db';

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          """CREATE TABLE Products(id INTEGER PRIMARY KEY,name TEXT NOT NULL, price INTEGER NOT NULL, quantity INTEGER NOT NULL);""");
      await db.execute(
          """CREATE TABLE Orders(id INTEGER PRIMARY KEY, products TEXT NOT NULL ) """);

      final List<Product> products = [
        const Product(id: 1, name: 'Product 1', price: 200, quantity: 999),
        const Product(id: 2, name: 'Product 2', price: 300, quantity: 999),
      ];

      for (Product product in products) {
        await db.insert("Products", product.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }, version: _version);
  }

  static Future<List<Product>?> getAllProducts() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Products");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => Product.fromJson(maps[index]),
    );
  }

  static Future<int> addOrder(Order order) async {
    final db = await _getDB();
    return await db.insert("Orders", order.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Order>?> getAllOrders() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('Orders');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => Order.fromDbJson(maps[index]),
    );
  }
}
