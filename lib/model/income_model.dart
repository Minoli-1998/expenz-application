import 'package:flutter/material.dart';

// income categories
enum IncomeCategory { salary, freelance, passive, sales }

// category images
final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.freelance : "assets/images/freelance.png",
  IncomeCategory.salary : "assets/images/salary.png",
  IncomeCategory.passive : "assets/images/bill.png",
  IncomeCategory.sales : "assets/images/bag.png",
};

// category colors
final Map<IncomeCategory, Color> incomeCategoryColors = {
  IncomeCategory.freelance: const Color(0xFFE57373),
  IncomeCategory.passive: const Color(0xFF81C784),
  IncomeCategory.sales: const Color(0xFF64B5F6),
  IncomeCategory.salary: const Color(0xFFFFD54F),
};

class Income {
  final int id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final DateTime time;
  final IncomeCategory category;

  Income({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.time,
    required this.category,
  });
}
