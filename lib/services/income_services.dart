import 'dart:convert';

import 'package:expenz_application/model/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeServices {
  // define the key for storing incomes in shared prefs
  static const String _incomeKey = 'income';

  // methode to save new income in shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      // create an instance from SharedPrefernces
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // getting the existing income list
      List<String>? existingIncomes = preferences.getStringList(_incomeKey);

      // converting income list into Income object list if it's not null
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // add the income to the list
      existingIncomeObjects.add(income);

      // converting Income object list into string list
      List<String> updatedIncomeList = existingIncomeObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the list in SharedPreferences
      await preferences.setStringList(_incomeKey, updatedIncomeList);

      // display a message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("New income saved successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // display a message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding Income"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // load the existing incomes from SharedExpereices
  Future<List<Income>> loadIncome() async {
    // creating insatance from shared prefernces
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // get existing income list from shared prefernces
    List<String>? existingIncomes = preferences.getStringList(_incomeKey);

    // converting them into Income object list if not null
    List<Income> loadIncomeObjects = [];
    if (existingIncomes != null) {
      loadIncomeObjects = existingIncomes
          .map((e) => Income.fromJSON(json.decode(e)))
          .toList();
    }

    return loadIncomeObjects;
  }

  // delete the income using id
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      // create the shared preferences instance
      SharedPreferences pref = await SharedPreferences.getInstance();

      // get the existing income String list from shared preferences
      List<String>? existingIncomes = pref.getStringList(_incomeKey);

      // converting to Income objects list if not null
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // deleting the income using id
      existingIncomeObjects.removeWhere((element) => element.id == id);

      // converting to String list
      List<String> updatedList = existingIncomeObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save in Shared preferences
      pref.setStringList(_incomeKey, updatedList);

      // display the message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income item deleted successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // display the message
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
