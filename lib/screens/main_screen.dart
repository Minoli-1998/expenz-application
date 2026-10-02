import 'package:expenz_application/model/expense_model.dart';
import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/screens/add_new_screen.dart';
import 'package:expenz_application/screens/budget_screen.dart';
import 'package:expenz_application/screens/home_screen.dart';
import 'package:expenz_application/screens/profile_screen.dart';
import 'package:expenz_application/screens/transactions_screen.dart';
import 'package:expenz_application/services/expense_services.dart';
import 'package:expenz_application/services/income_services.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // create an Expense list
  List<Expense> expenseList = [];

  // function to fetch expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseServices().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  // function to add a new expense
  void addNewexpense(Expense newExpense) async {
    await ExpenseServices().saveExpenses(newExpense, context);

    // update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // delete the expense
  void deleteExpense(Expense expense) async {
    await ExpenseServices().deleteExpense(expense.id, context);

    setState(() {
      expenseList.remove(expense);
    });
  }

  // create an income list
  List<Income> incomeList = [];

  // function to fetch incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeServices().loadIncome();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  // function to add new income
  void addNewIncome(Income newIncome) async {
    await IncomeServices().saveIncome(newIncome, context);

    // update the income list
    setState(() {
      incomeList.add(newIncome);
    });
  }

  // delete the income
  void deleteIncome(Income income) async {
    await IncomeServices().deleteIncome(income.id, context);

    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(expensesList: expenseList, incomeList: incomeList),
      TransactionsScreen(
        expensesList: expenseList,
        incomeList: incomeList,
        onDismissedExpense: deleteExpense,
        onDissmissedIncome: deleteIncome,
      ),
      AddNewScreen(addExpense: addNewexpense, addIncome: addNewIncome),
      BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        backgroundColor: kWhite,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: kWhite, size: 30),
            ),
            label: "",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

      body: pages[_currentIndex],
    );
  }
}
