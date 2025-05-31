import 'package:expense_app/ui/pages/add_expense_page.dart';
import 'package:expense_app/ui/pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui/pages/bloc/expense_state.dart';
import 'package:expense_app/ui/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            'assets/images/splash_image-logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 30, color: Colors.black),
          ),
        ],
        title: Text(
          "Expense",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_ ,state){

        if(state is LoadingExpenseState){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state is ErrorExpenseState){
          return Center(
            child: Text(state.errorMsg),
          );
        }

        if(state is LoadedExpenseState){
          print(state.mExpenses.length);

          var allData = state.mExpenses;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 62,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.person, size: 30),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          SizedBox(height: 5),
                          Text(
                            "Morning",
                            style: TextStyle(
                              color: Color(0XFF96989F),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Ashish",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 150),
                        decoration: BoxDecoration(
                          color: Color(0XFFEFF1FD),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                "This Month",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_downward_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Total Expense
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XFF6574D3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Expense total",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "\$3,734",
                              style: TextStyle(
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFFD06160),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "+\$240",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "than last month",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/expense_app_images copy 2.tiff'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Expense List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                // Expanded(
                //   child: ListView(
                //     children: [
                //       _buildExpenseItem('Shop', '-\$90'),
                //       _buildExpenseItem('Electronic', '-\$1290'),
                //       _buildExpenseItem('Transportation', '-\$60'),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(itemBuilder: (_, index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 11),
                      padding: EdgeInsets.all(11),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(allData[index].title, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              Text(allData[index].bal.toString(), style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                            ],
                          ),
                          Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allData[index].allExp.length,
                            itemBuilder: (_, childIndex){
                              return _buildExpenseItem(allData[index].allExp[childIndex].expTitle, allData[index].allExp[childIndex].expDesc, allData[index].allExp[childIndex].expAmt.toString());
                            },
                          ),
                        ],
                      )
                    );
                  }, itemCount: allData.length,),
                )
              ],
            ),
          );

        }

        return  Container();

      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddExpensePage()),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF7F6EFF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(String title, String desc, String amount) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(desc),
      trailing: Text(
        amount,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0XFFE88DBE),
        ),
      ),
    );
  }
}
