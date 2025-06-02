import 'dart:io';

import 'package:expense_app/data/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'models/user_model.dart';

class DBHelper {
  DBHelper._();

  ///private constructor
  static DBHelper getInstance() => DBHelper._();

  Database? mDB;

  static const String TABLE_EXPENSE = "expense";
  static const String TABLE_USER = "user";

  /// user table columns
  static const String COLUMN_USER_ID = "user_id";
  static const String COLUMN_USER_NAME = "user_name";
  static const String COLUMN_USER_EMAIL = "user_email";
  static const String COLUMN_USER_MOB_NO = "user_mob_no";
  static const String COLUMN_USER_PASS = "user_pass";

  /// expense table columns
  static const String COLUMN_EXP_ID = "exp_id";
  static const String COLUMN_EXP_TITLE = "exp_title";
  static const String COLUMN_EXP_DESC = "exp_desc";
  static const String COLUMN_EXP_AMT = "exp_amt";
  static const String COLUMN_EXP_BAL = "exp_bal";
  static const String COLUMN_EXP_CAT_ID = "exp_cat_id";
  static const String COLUMN_EXP_TYPE = "exp_type";
  static const String COLUMN_EXP_CREATED_AT = "exp_created_at";

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
    /*if(mDB==null){
      mDB = await openDB();
      return mDB!;
    } else {
      return mDB!;
    }*/
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "expDB.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      ///user table
      db.execute(
          "create table $TABLE_USER ( $COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_NAME text, $COLUMN_USER_EMAIL text, $COLUMN_USER_MOB_NO text, $COLUMN_USER_PASS text)");

      ///expense table
      db.execute(
          "create table $TABLE_EXPENSE ( $COLUMN_EXP_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXP_TITLE text, $COLUMN_EXP_DESC text, $COLUMN_EXP_AMT real, $COLUMN_EXP_BAL real, $COLUMN_EXP_CAT_ID integer, $COLUMN_EXP_TYPE integer, $COLUMN_EXP_CREATED_AT text)");
    });
  }

  ///events
  ///createUser
  Future<bool> createUser({required UserModel user}) async {
    var db = await initDB();

    int rowsEffected = await db.insert(TABLE_USER, user.toMap());

    return rowsEffected > 0;
  }

  ///checkIfUserAlreadyExists
  Future<bool> checkIfUserAlreadyExists({required String email}) async {
    var db = await initDB();

    List<Map<String, dynamic>> mData = await db
        .query(TABLE_USER, where: "$COLUMN_USER_EMAIL = ?", whereArgs: [email]);

    return mData.isNotEmpty;
  }

  ///authenticateUser
  Future<String> authenticateUser(
      {required String email, required String pass}) async {
    var db = await initDB();

    List<Map<String, dynamic>> mData = await db.query(TABLE_USER,
        where: "$COLUMN_USER_EMAIL = ?",
        whereArgs: [email]);

    if(mData.isNotEmpty){

      List<Map<String, dynamic>> mData = await db.query(TABLE_USER,
          where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?",
          whereArgs: [email, pass]);

      if(mData.isNotEmpty){

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("userId", mData[0][COLUMN_USER_ID]);

        return "LoggedIn Successfully";

      } else {
        return "Incorrect Password";
      }


    } else {
      return "Email not found";
    }



  }

  ///addExpense
  Future<bool> addExpense({required ExpenseModel expense}) async {
    var db = await initDB();

    ///get userId from sharedPrefs
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("userId")!;
    */expense.userId = 1;

    int rowsEffected = await db.insert(TABLE_EXPENSE, expense.toMap());

    return rowsEffected > 0;
  }

  ///fetchAllExpense
  Future<List<ExpenseModel>> fetchAllExpense() async {
    var db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = 1;

    List<Map<String, dynamic>> mData = await db.query(TABLE_EXPENSE,
        where: "$COLUMN_USER_ID = ?", whereArgs: [userId], orderBy: "$COLUMN_EXP_CREATED_AT DESC");

    List<ExpenseModel> allExp = [];

    for (Map<String, dynamic> eachExp in mData) {
      allExp.add(ExpenseModel.fromMap(eachExp));
    }

    return allExp;
  }

  ///updateExpense
  ///deleteExpense
}
