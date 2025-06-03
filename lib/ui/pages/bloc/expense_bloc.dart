import 'package:expense_app/app_constants.dart';
import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/data/models/filtered_exp_model.dart';
import 'package:expense_app/ui/pages/bloc/expense_event.dart';
import 'package:expense_app/ui/pages/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper dbHelper;

  List<FilteredExpModel> filterExpense(
      {required List<ExpenseModel> mExp, int filterType = 1}) {
    List<FilteredExpModel> filteredExp = [];

    ///1-> date, 2-> month, 3-> year, 4-> cat

    ///date-wise
    ///uniqueDates

    if(filterType<4){
      DateFormat df = DateFormat.yMMMEd();
      if(filterType==1){
        df = DateFormat.yMMMEd();
      } else if(filterType==2){
        df = DateFormat.yMMM();
      } else if(filterType==3){
        df = DateFormat.y();
      }

      List<String> uniquesDates = [];

      for (ExpenseModel eachExp in mExp) {
        String eachDate = df.format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expCreatedAt)));

        if (!uniquesDates.contains(eachDate)) {
          uniquesDates.add(eachDate);
        }
      }
      print("Unique dates : $uniquesDates");

      for (String eachDate in uniquesDates) {
        num bal = 0.0;
        List<ExpenseModel> eachDateExp = [];

        for (ExpenseModel eachExp in mExp) {
          String expDate = df.format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.expCreatedAt)));

          if (eachDate == expDate) {
            eachDateExp.add(eachExp);

            if (eachExp.expType == 1) {
              bal -= eachExp.expAmt;
            } else {
              bal += eachExp.expAmt;
            }
          }
        }

        print("$eachDate: $bal, ${eachDateExp.length}");

        filteredExp
            .add(FilteredExpModel(title: eachDate, bal: bal, allExp: eachDateExp));
      }

    }
    else {
      ///cat wise
      ///unique categories

      for(Map<String, dynamic> eachCat in AppConstants.mCat){
        num bal = 0.0;
        List<ExpenseModel> eachCatExp = [];

        for(ExpenseModel eachExp in mExp){

          if(eachExp.expCatId==eachCat["catId"]){
            eachCatExp.add(eachExp);

            if(eachExp.expType==1){
              bal-=eachExp.expAmt;
            } else {
              bal += eachExp.expAmt;
            }
          }

        }

        if(eachCatExp.isNotEmpty) {
          filteredExp.add(FilteredExpModel(
              title: eachCat["catName"], bal: bal, allExp: eachCatExp));
        }

      }


    }

    return filteredExp;
  }

  ExpenseBloc({required this.dbHelper}) : super(InitialExpenseState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(LoadingExpenseState());

      bool check = await dbHelper.addExpense(expense: event.mExpense);

      if (check) {
        var allExp = await dbHelper.fetchAllExpense();

        emit(LoadedExpenseState(mExpenses: filterExpense(mExp: allExp, filterType: event.filterValue)));
      } else {
        emit(ErrorExpenseState(errorMsg: "Expense not added"));
      }
    });


    on<GetInitialExpenseEvent>((event, emit) async {
      emit(LoadingExpenseState());

        var allExp = await dbHelper.fetchAllExpense();

        emit(LoadedExpenseState(mExpenses: filterExpense(mExp: allExp, filterType: event.filterValue)));
    });
  }
}
