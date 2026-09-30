import 'package:expenz_application/model/expense_model.dart';
import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:expenz_application/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _cardIndex = 0;
  ExpenseCategory _expenseCategory = ExpenseCategory.food;
  IncomeCategory _incomeCategory = IncomeCategory.freelance;

  // controllers for text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // disposing controllers
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // formatting date
  DateFormat dateFormat = DateFormat("MMMM EEEE");
  DateFormat dayFormat = DateFormat("dd");

  @override
  Widget build(BuildContext context) {
    String date = dateFormat.format(_selectedDate);
    String day = dayFormat.format(_selectedDate);

    return Scaffold(
      backgroundColor: _cardIndex == 0 ? kRed : kGreen,
      body: SingleChildScrollView(
        child: SafeArea(
          // stack was here before
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // container that includes toggle button and value
              Container(
                padding: EdgeInsets.all(kMainPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // expense and income toggle button
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
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 80,
                              ),
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
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 80,
                              ),
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

                    SizedBox(height: 30),

                    // value container
                    Text(
                      "How much?",
                      style: TextStyle(
                        fontSize: 14,
                        color: kWhite,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    TextField(
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: kWhite,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // form
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  child: Column(
                    children: [
                      // drop down field
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: "Category",
                          hintStyle: TextStyle(
                            color: kLightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: kGrey),
                          ),
                        ),
                        items: _cardIndex == 0
                            ? ExpenseCategory.values.map((category) {
                                return DropdownMenuItem<Object>(
                                  value: category,
                                  child: Text(category.name),
                                );
                              }).toList()
                            : IncomeCategory.values.map((category) {
                                return DropdownMenuItem<Object>(
                                  value: category,
                                  child: Text(category.name),
                                );
                              }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _cardIndex == 0
                                ? _expenseCategory = value as ExpenseCategory
                                : _incomeCategory = value as IncomeCategory;
                          });
                        },
                      ),

                      SizedBox(height: 15),

                      // title
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: kGrey),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: kGrey),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // amount
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Amount",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(color: kGrey),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // date row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // button
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedDate = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: kWhite,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Select Date",
                                    style: TextStyle(
                                      color: kWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // date  text
                          Text(
                            "$date $day",
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      // time row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // button
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedTime = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: kYellow,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.history_outlined, color: kWhite),
                                  SizedBox(width: 10),
                                  Text(
                                    "Select Time",
                                    style: TextStyle(
                                      color: kWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // date  text
                          Text(
                            _selectedTime.format(context),
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      Divider(
                        color: Color.fromRGBO(168, 168, 168, 0.21),
                        thickness: 3,
                        radius: BorderRadius.circular(20),
                      ),

                      CustomPageButton(
                        buttonColor: _cardIndex == 0 ? kRed : kGreen,
                        buttonText: "Add",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
