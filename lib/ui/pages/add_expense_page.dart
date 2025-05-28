import 'package:expense_app/app_constants.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  var amtController = TextEditingController();

  int selectedCatIndex = -1;

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
                                itemBuilder: (_, index){
                                  return InkWell(
                                    onTap: (){
                                      selectedCatIndex = index;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(AppConstants.mCat[index]["catImage"], width: 50, height: 50,),
                                        Text(AppConstants.mCat[index]["catName"])
                                      ],
                                    ),
                                  );
                                }),
                          );
                        });
                  },
                  child: selectedCatIndex>=0 ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${AppConstants.mCat[selectedCatIndex]["catName"]} - "),
                      Image.asset(AppConstants.mCat[selectedCatIndex]["catImage"], width: 30, height: 30,),


                    ],
                  ) : Text('Choose Category')),
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

                  },
                  child: Text('Select Type')),
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

                  },
                  child: Text('Select Date')),
            ),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {

                  },
                  child: Text('Add Expense',)),
            )
          ],
        ),
      ),
    );
  }
}
