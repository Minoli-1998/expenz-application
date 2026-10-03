import 'package:expenz_application/screens/onboarding_screen.dart';
import 'package:expenz_application/services/expense_services.dart';
import 'package:expenz_application/services/income_services.dart';
import 'package:expenz_application/services/user_services.dart';
import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:expenz_application/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String email = "";

  @override
  void initState() {
    UserServices.getUserDetails().then((value) {
      if (value['username'] != null && value['email'] != null) {
        setState(() {
          userName = value['username']!;
          email = value['email']!;
        });
      }
    });
    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.all(kMainPadding),
          decoration: BoxDecoration(
            color: kLightGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Logout?",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Are you sure do you wanna logout?",
                style: TextStyle(
                  color: kGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(kMainColor),
                    ),
                    onPressed: () async {
                      // clear user data
                      await UserServices.clearUserData();

                      // clear all expenses and incomes
                      if (context.mounted) {
                        await IncomeServices().clearAllIncomes(context);
                      }

                      if (context.mounted) {
                        await ExpenseServices().clearAllExpenses(context);
                      }

                      // navigate to onboarding screen
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return OnboardingScreen();
                            },
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: kWhite, fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(kMainColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: kWhite, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kMainPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    // profile image
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: kMainColor, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(100),
                        child: Image.asset(
                          "assets/images/user.jpg",
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(width: 20),

                    // column user name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: TextStyle(
                            color: kGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // username
                        Text(
                          userName,
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    // edit icon
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          color: kLightGrey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(Icons.edit_outlined, color: kBlack),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),

                SizedBox(height: 20),

                ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kMainColor,
                ),

                SizedBox(height: 20),

                ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kMainColor,
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () => _showBottomSheet(context),
                  child: ProfileCard(
                    icon: Icons.logout,
                    title: "Logout",
                    color: kRed,
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
