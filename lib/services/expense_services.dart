import 'dart:convert';

import 'package:expenz_application/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseServices {
  // define the key for storing expenses in shared prefs
  static const String _expenseKey = 'expenses';

  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      // create an instance of SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // get existing expenses list (JSON string list)
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      // convert existing JSON string list to Expense object list
      List<Expense> existingExpenseObjects = [];

      // the existing expenses list can be null
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // add the new Expense object
      existingExpenseObjects.add(expense);

      // convert all the expenses objects to JSON string list
      List<String> updatedExpensesList = existingExpenseObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      // save the updated list in SharedPreferences
      await prefs.setStringList(_expenseKey, updatedExpensesList);

      // display a message to the user after saving successfully
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("New expense saved successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding Expense"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // load the expenses from shared preferences stpes - the return type is Expense list
  Future<List<Expense>> loadExpenses() async {
    // creating shared preferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // create a String list to get StringList from shared preferences
    List<String>? existingExpenses = prefs.getStringList(_expenseKey);

    // convert string list into Expense objects list
    List<Expense> loadExpensesList = [];

    if (existingExpenses != null) {
      loadExpensesList = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }

    // return the Expense object list
    return loadExpensesList;
  }

  // delete the expense
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      // create shared preference instant
      SharedPreferences pref = await SharedPreferences.getInstance();

      // get existing expenses String list
      List<String>? existingExpenses = pref.getStringList(_expenseKey);

      // convert into Expense object list if not null
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // deleting the expense using id
      existingExpenseObjects.removeWhere((element) => element.id == id);

      // converting into String list
      List<String> updatedList = existingExpenseObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      // save to shared preferences
      await pref.setStringList(_expenseKey, updatedList);

      // displaying the message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense item deleted successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error occurred!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
