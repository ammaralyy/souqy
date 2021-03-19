import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class User{

  int id;
  String email;
  String password;
  String nikeName;

  User( this.id,this.email, this.password, this.nikeName);
}

class UsersDB {

  // database connection
  static Database _db;

  // database version
  static const int VERSION = 1;

  // database name
  static const String DATABASE = 'myUsers.db';

  // tables
  static const String TABLE_USERS = 'users';

  // table's column
  static const String ID = 'id';
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';
  static const String NIKENAME = 'nikeName';


  Future<Database> get db async {
    if (_db == null) {
      //open connection
      String path = join(await getDatabasesPath(), DATABASE);
      _db = await openDatabase(
          path, version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    }

    return _db;
  }

  _onCreate(Database db, int version) async {
    String sql = 'Create TABLE $TABLE_USERS ('
        '$ID INTEGER PRIMARY KEY,'
        '$EMAIL TEXT,'
        '$PASSWORD TEXT,'
        '$NIKENAME TEXT)';

    await db.execute(sql);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE $TABLE_USERS');
    await _onCreate(db, newVersion);
  }

  Future<User> save(User user) async {
    Database dbClient = await db;

    int id = await dbClient.insert(TABLE_USERS,
        {
          '$ID': user.id,
          '$EMAIL': user.email,
          '$PASSWORD': user.password,
          '$NIKENAME': user.nikeName
        });

    user.id = id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', id);

    return user;
  }

  Future<List<User>> showUsers() async {
    Database dbClient = await db;

    List<Map> myMap = await dbClient.query(
        TABLE_USERS, columns: [ID, EMAIL, PASSWORD, NIKENAME]);

    List<User> users = [];

    if (myMap.length > 0) {
      for (int i = 0; i < myMap.length; i++) {
        Map map = myMap[i];
        User user = User(
            map['id'], map['email'], map['password'], map['nikeName']);
        users.add(user);
      }
    }

    return users;
  }

  Future<int> deleteUser(int id) async {
    Database dbClient = await db;

    int record = await dbClient.delete(
        TABLE_USERS, where: '$ID=?', whereArgs: [id]);

    return record;
  }

  Future<int> updateUser(User user) async {
    Database dbClient = await db;

    int record = await dbClient.update(TABLE_USERS,
        {
          'password': user.password,
          'email':user.email,
          'nikeName':user.nikeName
        },
        where: '$ID=?', whereArgs: [user.id]);

    return record;
  }
}