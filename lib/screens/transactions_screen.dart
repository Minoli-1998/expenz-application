import 'package:expenz_application/model/expense_model.dart';
import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:expenz_application/widgets/expense_card.dart';
import 'package:expenz_application/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomeList;
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDissmissedIncome;

  const TransactionsScreen({
    super.key,
    required this.expensesList,
    required this.incomeList,
    required this.onDismissedExpense,
    required this.onDissmissedIncome,
  });

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kMainPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "See your financial report",
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 25),

                Text(
                  "Expenses",
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 15),

                // show all expenses
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.expensesList.isEmpty
                            ? Text(
                                "No expenses added yet, add some expenses here",
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : ListView.builder(
                                itemCount: widget.expensesList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final expense = widget.expensesList[index];
                                  return Dismissible(
                                    key: ValueKey(expense),
                                    direction: DismissDirection.startToEnd,
                                    onDismissed: (direction) {
                                      setState(() {
                                        widget.onDismissedExpense(expense);
                                      });
                                    },
                                    child: ExpenseCard(
                                      category: expense.category,
                                      description: expense.description,
                                      amount: expense.amount,
                                      time: expense.time,
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Income",
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 15),

                // show all expenses
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.incomeList.isEmpty
                            ? Text(
                                "No incomes added yet, add some incomes here",
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : ListView.builder(
                                itemCount: widget.incomeList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final income = widget.incomeList[index];
                                  return Dismissible(
                                    key: ValueKey(income),
                                    direction: DismissDirection.startToEnd,
                                    onDismissed: (direction) {
                                      setState(() {
                                        widget.onDissmissedIncome(income);
                                      });
                                    },
                                    child: IncomeCard(
                                      category: income.category,
                                      description: income.description,
                                      amount: income.amount,
                                      time: income.time,
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
