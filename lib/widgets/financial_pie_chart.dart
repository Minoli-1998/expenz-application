import 'package:expenz_application/model/expense_model.dart';
import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinancialPieChart extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  final bool isExpense;

  const FinancialPieChart({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isExpense,
  });

  @override
  State<FinancialPieChart> createState() => _FinancialPieChartState();
}

class _FinancialPieChartState extends State<FinancialPieChart> {
  // sections data
  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expenseCategoryTotal[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.health],
          value: widget.expenseCategoryTotal[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.shopping],
          value: widget.expenseCategoryTotal[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.subscription],
          value: widget.expenseCategoryTotal[ExpenseCategory.subscription] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.transport],
          value: widget.expenseCategoryTotal[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 20,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategoryTotal[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategoryTotal[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 20,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomeCategoryTotal[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 20,
        ),
      ];
    }
  }

  // getting total
  double getIncomeTotal() {
    return widget.incomeCategoryTotal.values.fold(
      0.0,
      (sum, value) => sum + value,
    );
  }

  double getExpenseTotal() {
    return widget.expenseCategoryTotal.values.fold(
      0.0,
      (sum, value) => sum + value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );

    return Container(
      height: 250,
      padding: EdgeInsets.all(kMainPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Text(
            (widget.isExpense ? getExpenseTotal() : getIncomeTotal()).toString(),
            style: TextStyle(
              color: kBlack,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
