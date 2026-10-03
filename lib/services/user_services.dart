import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  // methode to store user name and email in the shared pref
  static Future<void> storeUserDetails({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      // check whether the passwords are same
      if (password != confirmPassword) {
        // displaying a message for the user
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Passwords are not same!")));
      }

      // if the passwords are same store username and password in shared preference
      // create an instance of shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // store username and email
      await prefs.setString("username", username);
      await prefs.setString("email", email);

      // displaying a message for the user after saving data in SharedPreferences
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User details are saved successfully")),
      );
    } catch (e) {
      e.toString();
    }
  }

  // methode to whether username  is saved in shared pref
  static Future<bool> checkUsernameSaved() async {
    // creating an instance from shared prefs
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // store username in a variable
    String? username = prefs.getString('username');

    return username != null;
  }

  // methode to get username and email
  static Future<Map<String, String>> getUserDetails() async {
    // creating sharedPreferences instance
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userName = pref.getString('username');
    String? email = pref.getString('email');

    return {"username": userName!, "email": email!};
  }

  // methode to remove user data
  static Future<void> clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove('username');
    await preferences.remove('email');
  }
}
