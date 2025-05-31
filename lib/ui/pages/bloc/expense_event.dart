import 'package:expense_app/data/models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel mExpense;
  AddExpenseEvent({required this.mExpense});
}