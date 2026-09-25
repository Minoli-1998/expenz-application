import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const SharedOnboardingScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 200,
            fit: BoxFit.cover,
          ),
      
          SizedBox(
            height: 20,
          ),
      
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              color: kBlack,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
      
          SizedBox(
            height: 20,
          ),
      
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: kGrey,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
