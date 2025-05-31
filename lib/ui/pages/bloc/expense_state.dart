import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/data/models/filtered_exp_model.dart';

abstract class ExpenseState{}

class InitialExpenseState extends ExpenseState{}
class LoadingExpenseState extends ExpenseState{}
class LoadedExpenseState extends ExpenseState{
  List<FilteredExpModel> mExpenses;
  LoadedExpenseState({required this.mExpenses});
}
class ErrorExpenseState extends ExpenseState{
  String errorMsg;
  ErrorExpenseState({required this.errorMsg});
}