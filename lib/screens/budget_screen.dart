import 'package:expenz_application/model/expense_model.dart';
import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/widgets/category_card.dart';
import 'package:flutter/material.dart';

import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:expenz_application/widgets/financial_pie_chart.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;

  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _buttonIndex = 0;

  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _buttonIndex == 0
        ? widget.expenseCategoryTotal
        : widget.incomeCategoryTotal;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(kMainPadding),
            child: Column(
              children: [
                Text(
                  "Financial Report",
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: kLightGrey,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // expense container button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonIndex = 0;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _buttonIndex == 0
                                ? kMainColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: _buttonIndex == 0 ? kWhite : kBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // expense container button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonIndex = 1;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _buttonIndex == 1
                                ? kMainColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _buttonIndex == 1 ? kWhite : kBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // pie chart
                FinancialPieChart(
                  expenseCategoryTotal: widget.expenseCategoryTotal,
                  incomeCategoryTotal: widget.incomeCategoryTotal,
                  isExpense: _buttonIndex == 0 ? true : false,
                ),

                SizedBox(height: 20),

                // expenses or incomes list view
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final category = data.keys.toList()[index];
                      final total = data.values.toList()[index];

                      return CategoryCard(
                        title: category.name,
                        amount: total,
                        total: data.values.reduce(
                          (value, element) => value + element,
                        ),
                        progressBarColor: getCategoryColor(category),
                        isExpense: _buttonIndex == 0,
                      );
                    },
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
