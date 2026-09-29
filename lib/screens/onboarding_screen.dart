import 'package:expenz_application/data/onboarding_data.dart';
import 'package:expenz_application/screens/onboarding/front_page.dart';
import 'package:expenz_application/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz_application/screens/user_form_screen.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // using stack to layer pages, dot container and button on each other
          // first layer is page
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      imagePath: OnboardingData.onboardingData[0].imagePath,
                      title: OnboardingData.onboardingData[0].title,
                      description: OnboardingData.onboardingData[0].description,
                    ),
                    SharedOnboardingScreen(
                      imagePath: OnboardingData.onboardingData[1].imagePath,
                      title: OnboardingData.onboardingData[1].title,
                      description: OnboardingData.onboardingData[1].description,
                    ),
                    SharedOnboardingScreen(
                      imagePath: OnboardingData.onboardingData[2].imagePath,
                      title: OnboardingData.onboardingData[2].title,
                      description: OnboardingData.onboardingData[2].description,
                    ),
                  ],
                ),

                // dot container
                Container(
                  alignment: Alignment(0, 0.7),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kGrey,
                    ),
                  ),
                ),

                // button
                Container(
                  alignment: Alignment(0, 0.99),
                  child: !showDetailsPage
                      ? GestureDetector(
                          onTap: () {
                            _controller.animateToPage(
                              _controller.page!.toInt() + 1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: CustomPageButton(
                            buttonColor: kMainColor,
                            buttonText: showDetailsPage
                                ? "Get Started"
                                : "Next",
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserFormScreen(),
                              ),
                            );
                          },
                          child: CustomPageButton(
                            buttonColor: kMainColor,
                            buttonText: showDetailsPage
                                ? "Get Started"
                                : "Next",
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
