import 'package:expense_app/data/models/expense_model.dart';

class FilteredExpModel {
  String title;
  num bal;
  List<ExpenseModel> allExp;

  FilteredExpModel({
    required this.title,
    required this.bal,
    required this.allExp,
  });
}
