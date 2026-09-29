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
}
