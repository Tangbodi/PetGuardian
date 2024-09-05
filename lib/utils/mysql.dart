import 'package:mysql_client/mysql_client.dart';


class DatabaseConnection {
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  factory DatabaseConnection() => _instance;
  DatabaseConnection._internal();

  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
      host: "localhost", // Your host IP address or server name
      port: 3306, // The port the server is running on
      userName: "root", // Your username
      password: "1992530", // Your password
      databaseName: "pet_management", // Your database name
    );

    await conn.connect();
    return conn;
  }
}
