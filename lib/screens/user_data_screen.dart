import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  bool _rememberMe = false;

  // form key for the form validations
  final _formKey = GlobalKey<FormState>();

  // controllers for the fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // after we using form controllers it's not useful for the other pages
  // so we're disposing the garbage values
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: kBlack,
                  ),
                ),

                SizedBox(height: 30),

                // form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // user name input field
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 10),

                      // user email input field
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your e-mail";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 10),

                      // password
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 10),

                      // confirm password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please enter the same password";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                            color: kGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 30),

                      Row(
                        children: [
                          Text(
                            "Remember me for the next time",
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      GestureDetector(
                        onTap: () {
                          if(_formKey.currentState!.validate()) {
                            // process with user entered data
                            String userName = _userNameController.text;
                            String userEmail = _emailController.text;
                            String password = _passwordController.text;
                            String confirmedPassword = _confirmPasswordController.text;
                          }
                        },
                        child: CustomPageButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
