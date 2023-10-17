import 'package:facebook_app/database/config.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database mySqlite;
void openMyDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  mySqlite = await openDatabase(
    join(await getDatabasesPath(), DatabaseConfig.DATABASE_NAME),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, address TEXT, className TEXT, gpa DOUBLE)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 2,
  );
}

Database database() {
  return mySqlite;
}