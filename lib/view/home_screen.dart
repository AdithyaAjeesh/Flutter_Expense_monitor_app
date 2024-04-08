import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controller/function_provider.dart';
import 'package:flutter_expense_tracker_app/model/expense_model.dart';
import 'package:flutter_expense_tracker_app/service/expense_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<ExpenseModel>>(
        future: ExpenseService().getAllExpense(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<ExpenseModel> expenseList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: expenseList.length,
              itemBuilder: (context, index) {
                final ExpenseModel expense = expenseList[index];
                return GestureDetector(
                  onTap: () {
                    provider.navigateToDetailScreen(
                      context,
                      expense.name,
                      expense.price,
                      expense.date.toString(),
                      expense.id,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.orange,
                        width: 3,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Spent On: ${expense.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          "Price: ${expense.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addScreenProvider(context);
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
