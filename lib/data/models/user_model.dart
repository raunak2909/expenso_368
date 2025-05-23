import 'package:expense_app/data/exp_db_helper.dart';

class UserModel {
  String? userId;
  String userName;
  String userEmail;
  String userMobNo;
  String userPass;

  UserModel({
    this.userId,
    required this.userName,
    required this.userEmail,
    required this.userMobNo,
    required this.userPass
  });

  factory UserModel.fromMap(Map<String, dynamic> map) =>
      UserModel(
          userId: map[DBHelper.COLUMN_USER_ID],
          userName: map[DBHelper.COLUMN_USER_NAME],
          userEmail: map[DBHelper.COLUMN_USER_EMAIL],
          userMobNo: map[DBHelper.COLUMN_USER_MOB_NO],
          userPass: map[DBHelper.COLUMN_USER_PASS]);

  Map<String, dynamic> toMap() => {
    DBHelper.COLUMN_USER_NAME : userName,
    DBHelper.COLUMN_USER_EMAIL : userEmail,
    DBHelper.COLUMN_USER_MOB_NO : userMobNo,
    DBHelper.COLUMN_USER_PASS : userPass,
  };

}
