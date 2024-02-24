import 'package:cart_app_norq/authentication/controller/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
          child: Consumer<AuthProvider>(
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SignUp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: value.usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.email),
                      label: Text('Email')),
                      validator: value.emailValidation,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: value.passwordController,
                  obscureText: value.isSUHidden,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                      suffix: GestureDetector(
                        onTap: () => value.changeSUHVisibility(),
                        child:Icon( value.isSUHidden
                          ? Icons.visibility_off
                          : Icons.visibility)),
                      label: Text('Password')),
                      validator: value.passwordValidation,
                ),
                
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: value.cfpasswordController,
                  obscureText: value.isCfHidden,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                      suffix: GestureDetector(
                        onTap: () => value.changeCFVisibility(),
                        child:Icon( value.isCfHidden
                          ? Icons.visibility_off
                          : Icons.visibility)),
                      label: Text('Confirm Password')),
                      validator: (cfPassword) {
                        if(value.passwordController.text.trim() == cfPassword?.trim()){
                          return null;
                        }
                        return 'Password mismatch';
                      },
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () => value.signupUser(
                        value.usernameController.text.trim(),
                        value.passwordController.text.trim(),context),
                    child: Text('Create account')),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}