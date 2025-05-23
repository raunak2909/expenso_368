import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/ui/features/auth/bloc/user_event.dart';
import 'package:expense_app/ui/features/auth/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  DBHelper dbHelper;
  UserBloc({required this.dbHelper}) : super(UserInitialState()) {

    on<RegisterUserEvent>((event, emit) async{

      emit(UserLoadingState());

      bool oldUser = await dbHelper.checkIfUserAlreadyExists(email: event.newUser.userEmail);

      if(!oldUser){
        bool check = await dbHelper.createUser(user: event.newUser);

        if(check){
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: "Something went wrong"));
        }
      } else {
        emit(UserFailureState(errorMsg: "Email already exists!!"));
      }

    });

  }

}

