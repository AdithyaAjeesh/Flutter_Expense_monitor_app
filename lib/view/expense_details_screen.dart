import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controller/function_provider.dart';
import 'package:provider/provider.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final String name;
  final String price;
  final String date;
  final index;
  const ExpenseDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.date,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 280,
          decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Spend on: $name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Money spend: $price',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Date: $date',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  provider.deleteExpenseProvider(index, context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.orange),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
