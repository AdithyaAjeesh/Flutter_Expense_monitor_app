import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/model/expense_model.dart';
import 'package:flutter_expense_tracker_app/service/expense_service.dart';
import 'package:flutter_expense_tracker_app/view/expense_details_screen.dart';

class FunctionProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final date = DateTime.now().toString();
  final ExpenseService expenseService = ExpenseService();
  Color backgroundColorProvider = Colors.orange;

  Future<void> addScreenProvider(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(hintText: 'Enter Expense Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration:
                    const InputDecoration(hintText: 'Enter Expense Price'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  addExpenseProvider();
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> addExpenseProvider() async {
    final name = nameController.text.trim();
    final price = priceController.text.trim();
    if (name.isEmpty || price.isEmpty) {
      return;
    }
    final expense = ExpenseModel(
      id: 1,
      name: name,
      price: price,
      date: date,
    );
    expenseService.addExpense(expense);
    notifyListeners();
  }

  Future<void> getAllExpenseProvider() async {
    expenseService.getAllExpense();
    notifyListeners();
  }

  Future<void> deleteExpenseProvider(index, context) async {
    expenseService.deleteExpense(index);
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future<void> deleteAllDataProvider() async {
    expenseService.deleteAllData();
    notifyListeners();
  }

  Future<void> editExpenseProvider(ExpenseModel value, context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Expense',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(hintText: 'Enter Expense Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration:
                    const InputDecoration(hintText: 'Enter Expense Price'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  expenseService.editExpense(value);
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              )
            ],
          ),
        );
      },
    );
  }

  void navigateToDetailScreen(context, name, price, date, index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(
          name: name,
          price: price,
          date: date,
          index: index,
        ),
      ),
    );
  }
}
