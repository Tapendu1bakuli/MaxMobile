import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> DataBaseInsert() async {
  final database = await openDatabase1();

  final insertedId = await insertData(database);
  if (insertedId != null) {
    print('Data inserted with ID: $insertedId');
  } else {
    print('Failed to insert data');
  }

  await database.close();
}

Future<void> DataBaseDelete() async {
  final database = await openDatabase1();

  final insertedId = await insertData(database);
  final deleteCount = await removeData(database, insertedId);
  if (deleteCount > 0) {
    print('Data deleted successfully: $insertedId');
  } else {
    print('Failed to delete data');
  }
  await database.close();
}

Future<Database> openDatabase1() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'my_database.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      try {
        await db.execute('''
          CREATE TABLE my_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image TEXT,
            name TEXT,
            mobile TEXT,
            email TEXT,
            address TEXT,
            lat TEXT,
            lng TEXT,
            isCompleted INTEGER,
            description TEXT
          )
        ''');
      } catch (e, s) {
        print(s);
      }
    },
  );
}

Future<void> RetriveData() async {
  final database = await openDatabase1();
  final isDataExists = await checkDataExists(database);
  if (!isDataExists) {
    print("No Data Found");
  } else {
    print('Data already exists in the database');
  }

  final insertedData = await getInsertedData(database);
  if (insertedData.isNotEmpty) {
    print('Inserted Data:');
    for (final row in insertedData) {
      print('Image: ${row['image']}');
      print('Name: ${row['name']}');
      print('Mobile: ${row['mobile']}');
      print('Email: ${row['email']}');
      print('Address: ${row['address']}');
      print('----------------------');
    }
  } else {
    print('No inserted data found');
  }
  await database.close();
}

Future<void> DeleteAll() async {
  final database = await openDatabase1();

  await removeAllData(database);

  await database.close();
}

Future<int> insertData(Database database) async {
  final row = {
    'image': 'image_url',
    'name': 'John Doe',
    'mobile': '1234567890',
    'email': 'johndoe@example.com',
    'description': 'description',
    'address': '71A, DCM street',
    'lat': '28.7041',
    'lng': '77.1025',
    'isCompleted': 1
  };

  final insertedId = await database.insert('my_table', row);
  return insertedId;
}

Future<int> removeData(Database database, int id) async {
  final deleteCount = await database.delete(
    'my_table',
    where: 'id = ?',
    whereArgs: [id],
  );
  return deleteCount;
}

Future<List<Map<String, dynamic>>> getInsertedData(Database database) async {
  final results = await database.query('my_table',orderBy: "id");
  return results;
}

Future<bool> checkDataExists(Database database) async {
  final results = await database.query('my_table');
  return results.isNotEmpty;
}

Future<void> removeAllData(Database database) async {
  await database.delete('my_table');
}
Future<void> updateIsCompleted(Database database,int id, int isCompleted) async {
  await database.update(
    'my_table',
    {'isCompleted': isCompleted},
    where: 'id = ?',
    whereArgs: [id],
  );
}
