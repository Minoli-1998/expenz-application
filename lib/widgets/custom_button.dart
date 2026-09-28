import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomPageButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;

  const CustomPageButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMainPadding),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: buttonColor,),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            color: kWhite,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
