// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/login/login_view_model.dart';
import 'package:quranhealer/services/login/login_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

    // ignore: unused_element

    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 40.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: emailController,
            validator: (email) {
              if (email != null && !EmailValidator.validate(email)) {
                return 'Enter a valid email';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              hintText: 'Masukkan Email',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
          // Input Password
          //========================================================
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: loginViewModel.obscureText,
            controller: passwordController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  loginViewModel.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  loginViewModel.toggleObscureText();
                },
              ),
              hintText: 'Masukkan Password',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot Password ?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 25.0),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF0E6969),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    loginViewModel.setLoading(true);
                    FocusScope.of(context).unfocus();
                    var res = await LoginService().postLogin(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (res.containsKey('accessToken')) {
                      loginViewModel.setLoading(false);
                      String accessToken = res['accessToken'] ?? '';

                      saveToken(valueToken: accessToken);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const BottomBar(
                            dashboardIndex: 0,
                            currentIndex: 0,
                          ),
                        ),
                        (route) => false,
                      );
                    } else {
                      loginViewModel.setLoading(false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        res['error'],
                        style: const TextStyle(color: Colors.white),
                      )));
                    }
                  }
                },
                child: !loginViewModel.loading
                    ? const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    : const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
