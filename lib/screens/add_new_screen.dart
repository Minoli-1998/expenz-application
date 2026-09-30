import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:flutter/material.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _cardIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cardIndex == 0 ? kRed : kGreen,
      body: SingleChildScrollView(
        child: SafeArea(child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kMainPadding),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _cardIndex = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _cardIndex == 0 ? kMainColor : kWhite,
                            ),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 16,
                                color: _cardIndex == 0 ? kWhite : kBlack,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _cardIndex = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _cardIndex == 1 ? kMainColor : kWhite,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 16,
                                color: _cardIndex == 1 ? kWhite : kBlack,
                                fontWeight: FontWeight.normal,
                              ),
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
        )),
      ),
    );
  }
}