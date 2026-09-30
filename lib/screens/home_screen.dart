import 'package:expenz_application/screens/income_expense_card.dart';
import 'package:expenz_application/services/user_services.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";

  @override
  void initState() {
    UserServices.getUserDetails().then((value) {
      if (value['username'] != null) {
        setState(() {
          userName = value['username']!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        amount: 5000,
                      ),

                      IncomeExpenseCard(
                        bgColor: kRed,
                        imageUrl: 'assets/images/expense.png',
                        title: 'Expenses',
                        amount: 1200,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
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
