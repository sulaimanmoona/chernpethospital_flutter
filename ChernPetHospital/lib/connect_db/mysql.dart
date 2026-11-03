import 'package:mysql1/mysql1.dart';
import 'dart:async';

class Mysql {
  static String host = 'localhost',
      user = 'root',
      password = 'root',
      db = 'bkpharmacy';
  static int port = 3307;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
