import 'package:expenz_application/model/expense_model.dart';
import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/screens/income_expense_card.dart';
import 'package:expenz_application/services/user_services.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:expenz_application/widgets/expense_card.dart';
import 'package:expenz_application/widgets/line_chart_sample.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomeList;

  const HomeScreen({
    super.key,
    required this.expensesList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  double expenseAmount = 0;
  double incomeAmount = 0;

  @override
  void initState() {
    UserServices.getUserDetails().then((value) {
      if (value['username'] != null) {
        setState(() {
          userName = value['username']!;
        });
      }
    });

    setState(() {
      // calculating the expense amount
      for (var i = 0; i < widget.expensesList.length; i++) {
        expenseAmount += widget.expensesList[i].amount;
      }

      // calculating the income amount
      for (var i = 0; i < widget.incomeList.length; i++) {
        incomeAmount += widget.incomeList[i].amount;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kMainColor.withAlpha(100),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // profile image
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kMainColor, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(width: 20),

                          // user name
                          Text(
                            "Welcome $userName",
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: kMainColor),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IncomeExpenseCard(
                        bgColor: kGreen,
                        imageUrl: 'assets/images/income.png',
                        title: 'Income',
                        amount: incomeAmount,
                      ),

                      IncomeExpenseCard(
                        bgColor: kRed,
                        imageUrl: 'assets/images/expense.png',
                        title: 'Expenses',
                        amount: expenseAmount,
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.all(kMainPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spend Frequency",
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 20),

                  LineChartSample(),

                  // recent transactions
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kMainPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Transaction",
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffEEE5FF),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          final expense =
                                              widget.expensesList[index];
                                          return ExpenseCard(
                                            category: expense.category,
                                            description: expense.description,
                                            amount: expense.amount,
                                            time: expense.time,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
