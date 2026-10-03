import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final double total;
  final Color progressBarColor;
  final bool isExpense;

  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.total,
    required this.progressBarColor,
    required this.isExpense,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    double progressWidth = widget.total != 0
        ? MediaQuery.of(context).size.width * (widget.amount / widget.total)
        : 0;

    return Container(
      padding: EdgeInsets.all(kMainPadding),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFCFCFC),
                  borderRadius: BorderRadius.circular(32),
                  border: BoxBorder.all(
                    color: kWhite,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: widget.progressBarColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),

                    SizedBox(width: 15),

                    Text(
                      widget.title,
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // amount
              Text(
                widget.isExpense
                    ? "-\$${widget.amount}"
                    : "+\$${widget.amount}",
                style: TextStyle(
                  color: widget.isExpense ? kRed : kGreen,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // progress bar
          Container(
            height: 10,
            width: progressWidth,
            decoration: BoxDecoration(
              color: widget.progressBarColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
