import 'package:cart_app_norq/authentication/authentication_helper.dart';
import 'package:cart_app_norq/home/screen/home_screen.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final cfpasswordController = TextEditingController();
  bool isHidden = true;
  bool isSUHidden = true;
  bool isCfHidden = true;

  void changeVisibility() {
    isHidden = !isHidden;
    notifyListeners();
  }

  void changeSUHVisibility() {
    isSUHidden = !isSUHidden;
    notifyListeners();
  }

  void changeCFVisibility() {
    isCfHidden = !isCfHidden;
    notifyListeners();
  }

  String? emailValidation(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (email?.isEmpty ?? true) {
      return 'Enter email';
    } else {
      if (!(email!.contains(regex))) {
        return "Invalid Email";
      }
      return null;
    }
  }

  String? passwordValidation(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Enter password';
    } else if (password!.length < 6) {
      return 'Minimum length is 6';
    }
    return null;
  }

  void loginUser(String email, String password, BuildContext context) {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        AuthenticationHelper()
            .signIn(email: email, password: password)
            .then((result) {
          if (result == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          } else {
            print('login result ${result}');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result.toString())));
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter Credentials')));
    }
  }

  void signupUser(String email, String password, BuildContext context) {
    print('$email : $password');
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        AuthenticationHelper()
            .signUp(email: email, password: password)
            .then((result) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text((result ?? 'Success').toString())));
          if (result == null) {
            usernameController.clear();
            passwordController.clear();
            cfpasswordController.clear();
            Navigator.pop(context);
            print('sign in');
          } else {
            print('sign result ${result.runtimeType}');
          }
        });
      } catch (e) {
        print('step5');
        print(e);
      }
    } else {
      print('step6');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter Credentials')));
    }
  }
}
