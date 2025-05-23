import 'package:expense_app/data/models/user_model.dart';

abstract class UserEvent{}

class RegisterUserEvent extends UserEvent{
  UserModel newUser;
  RegisterUserEvent({required this.newUser});
}