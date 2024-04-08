import 'package:flutter_expense_tracker_app/model/expense_model.dart';
import 'package:hive/hive.dart';

class ExpenseService {
  Future<void> addExpense(ExpenseModel value) async {
    final expenseDB = await Hive.openBox<ExpenseModel>('name');
    expenseDB.add(value);
  }

  Future<List<ExpenseModel>> getAllExpense() async {
    final expenseDB = await Hive.openBox<ExpenseModel>('name');
    return expenseDB.values.toList();
  }

  Future<void> deleteExpense(index) async {
    final expenseDB = await Hive.openBox<ExpenseModel>('name');
    expenseDB.deleteAt(index);
    getAllExpense();
  }

  Future<void> editExpense(ExpenseModel value) async {
    final expenseDB = await Hive.openBox<ExpenseModel>('name');
    expenseDB.put(value.id, value);
  }

  Future<void> deleteAllData() async {
    await Hive.box<ExpenseModel>('name').clear();
  }
}
