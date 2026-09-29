import 'package:expenz_application/utils/colors.dart';
import 'package:expenz_application/utils/constants.dart';
import 'package:expenz_application/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  bool _rememberMe = false;

  // form key
  final _formKey = GlobalKey<FormState>();

  // controllers for the form fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // the values of above variables will store in memory. But we don't need that data to other pages. So simply we can dispose those values
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
            padding: const EdgeInsets.all(kMainPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 30),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // user name
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 15),

                      // email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please enter your email";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 15),

                      // password
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please enter your password";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 15),

                      // confirm password
                      TextFormField(
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please enter your same password";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                                  _rememberMe = !_rememberMe;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      // submit button
                      GestureDetector(
                        onTap: () {
                          // if the user entered data validated process forward
                          if(_formKey.currentState!.validate()) {
                            // process with the data
                            // getting user entered data
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword = _confirmPasswordController.text;
                          }
                        },
                        child: CustomPageButton(
                          buttonColor: kMainColor,
                          buttonText: "Next",
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
