import 'package:expenz_application/model/income_model.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeCard extends StatelessWidget {
  final IncomeCategory category;
  final String description;
  final double amount;
  final DateTime time;

  const IncomeCard({
    super.key,
    required this.category,
    required this.description,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kLightGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // icon container
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: incomeCategoryColors[category]?.withValues(
                    alpha: 0.45,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  incomeCategoryImages[category]!,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text(
                    description,
                    style: TextStyle(
                      color: kGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+\$$amount",
                style: TextStyle(
                  color: kGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                DateFormat('h:mm a').format(time),
                style: TextStyle(
                  color: kGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
