import 'package:expense_app/app_constants.dart';
import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/ui/pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui/pages/bloc/expense_event.dart';
import 'package:expense_app/ui/pages/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  var amtController = TextEditingController();

  int selectedCatIndex = -1;

  List<String> mExpType = ["Debit", "Credit"];
  String selectedExpType = "Debit";

  DateTime? selectedDate;
  DateFormat df = DateFormat.yMMMEd();
  DBHelper? dbHelper;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title is Required";
                } else {
                  return null;
                }
              },
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Desc is Required";
                } else {
                  return null;
                }
              },
              controller: descController,
              decoration: InputDecoration(
                labelText: 'Desc',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Amount is Required";
                } else {
                  return null;
                }
              },
              controller: amtController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            height: 400,
                            padding: EdgeInsets.only(top: 11, bottom: 11),
                            child: GridView.builder(
                                itemCount: AppConstants.mCat.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
                                      selectedCatIndex = index;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          AppConstants.mCat[index]["catImage"],
                                          width: 50, height: 50,),
                                        Text(
                                            AppConstants.mCat[index]["catName"])
                                      ],
                                    ),
                                  );
                                }),
                          );
                        });
                  },
                  child: selectedCatIndex >= 0 ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${AppConstants
                          .mCat[selectedCatIndex]["catName"]} - "),
                      Image.asset(
                        AppConstants.mCat[selectedCatIndex]["catImage"],
                        width: 30, height: 30,),


                    ],
                  ) : Text('Choose Category')),
            ),
            SizedBox(
              height: 11,
            ),
            /*DropdownButton(
              value: selectedExpType,
                items: mExpType.map((e){
              return DropdownMenuItem(child: Text(e), value: e,);
            }).toList(), onChanged: (value){
                selectedExpType = value!;
                setState(() {

                });
            }),*/
            /*SizedBox(
              width: double.infinity,
              child: DropdownMenu(
                textAlign: TextAlign.center,
                width: double.infinity,
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  )
                ),
                initialSelection: selectedExpType,
                  onSelected: (value){
                  selectedExpType = value!;
                  },
                  dropdownMenuEntries: mExpType.map((e){
                return DropdownMenuEntry(value: e, label:e);
              }, ).toList()),
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: mExpType.map((e) {
                return RadioMenuButton(
                    value: e, groupValue: selectedExpType, onChanged: (value) {
                  selectedExpType = value!;
                  setState(() {

                  });
                }, child: Text(e));
              }).toList(),
            ),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 183)),
                        lastDate: DateTime.now());

                    setState(() {

                    });
                  },
                  child: Text(df.format((selectedDate ?? DateTime.now())))),
            ),
            SizedBox(
              height: 11,
            ),
            BlocListener<ExpenseBloc, ExpenseState>(
                listener: (_, state){

                  if(state is LoadingExpenseState){
                    isLoading = true;
                    setState(() {

                    });
                  } else if(state is ErrorExpenseState){
                    isLoading = false;
                    setState(() {

                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  } else if(state is LoadedExpenseState){
                    isLoading = false;
                    Navigator.pop(context);
                  }

            }, child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    ///exp model
                    ///bloc
                    ///event
                    ///state
                    ///dbhelper

                    if (selectedCatIndex >= 0) {

                      ExpenseModel newExpense = ExpenseModel(
                          expTitle: titleController.text,
                          expDesc: descController.text,
                          expAmt: double.parse(amtController.text),
                          expBal: 0,
                          expCatId: AppConstants.mCat[selectedCatIndex]["catId"],
                          expType: selectedExpType == "Debit" ? 1 : 2,
                          expCreatedAt: (selectedDate ?? DateTime.now()).millisecondsSinceEpoch.toString());

                      context.read<ExpenseBloc>().add(AddExpenseEvent(mExpense: newExpense));



                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select a category")));
                    }
                  }, child: isLoading ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 11,),
                      Text('Adding Expense...'),
                    ],
                  ) : Text('Add Expense',)),
            ),)
          ],
        ),
      ),
    );
  }
}
