import 'package:expenz_application/model/onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> onboardingData = [
    OnboardingModel(
      title: "Gain total control of your money",
      description: "Become your own money manager and make every cent count",
      imagePath: "assets/images/onboard_1.png",
    ),
    OnboardingModel(
      title: "Know where your money goes",
      description:
          "Track your transaction easily,with categories and financial report",
      imagePath: "assets/images/onboard_3.png",
    ),
    OnboardingModel(
      title: "Planning ahead",
      description: "Setup your budget for each category so you in control",
      imagePath: "assets/images/onboard_2.png",
    ),
  ];
}
