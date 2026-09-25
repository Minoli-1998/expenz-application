import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomPageButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  const CustomPageButton({
    super.key,
    required this.buttonName,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height * 0.075,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
