import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 1)
class ExpenseModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final String date;

  ExpenseModel({
    required this.id,
    required this.name,
    required this.price,
    required this.date,
  });
}
