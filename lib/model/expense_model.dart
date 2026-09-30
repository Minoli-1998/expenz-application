import 'package:flutter/material.dart';

enum ExpenseCategory { shopping, subscription, food, health, transport }

// category images
final Map<ExpenseCategory, String> expenseCategoryImages = {
  ExpenseCategory.shopping: "assets/images/bag.png",
  ExpenseCategory.subscription: "assets/images/bill.png",
  ExpenseCategory.food: "assets/images/restaurant.png",
  ExpenseCategory.health: "assets/images/health.png",
  ExpenseCategory.transport: "assets/images/car.png",
};

// category colors
final Map<ExpenseCategory, Color> expenseCategoryColors = {
  ExpenseCategory.food: const Color(0xFFE57373),
  ExpenseCategory.transport: const Color(0xFF81C784),
  ExpenseCategory.health: const Color(0xFF64B5F6),
  ExpenseCategory.shopping: const Color(0xFFFFD54F),
  ExpenseCategory.subscription: const Color(0xFF9575CD),
};

class Expense {
  final int id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final DateTime time;
  final ExpenseCategory category;

  Expense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.time,
    required this.category,
  });

  // SERIALIZATION
  // converting the Expense object to JSON object
  // in JSON the key must be a String
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
    };
  }

  // DESERIALIZATION
  // create an Expense object from a JSON object
  // json is the name of the object we got from JSON object deserialization not a keyword
  factory Expense.fromJSON(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      category: ExpenseCategory.values[json['category']],
    );
  }
}
