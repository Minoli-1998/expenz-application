import 'package:expenz_application/utils/colors.dart';
import 'package:flutter/material.dart';

class IncomeExpenseCard extends StatefulWidget {
  final Color bgColor;
  final String imageUrl;
  final String title;
  final double amount;

  const IncomeExpenseCard({
    super.key,
    required this.bgColor,
    required this.imageUrl,
    required this.title,
    required this.amount,
  });

  @override
  State<IncomeExpenseCard> createState() => _IncomeExpenseCardState();
}

class _IncomeExpenseCardState extends State<IncomeExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              widget.imageUrl,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(
            width: 10,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: kWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),

              Text(
                "\$${widget.amount}",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 25,
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
