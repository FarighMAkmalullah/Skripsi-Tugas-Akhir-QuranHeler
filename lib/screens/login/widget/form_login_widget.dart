import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
              // hintStyle: GoogleFonts.roboto(
              //   fontWeight: FontWeight.w400,
              //   fontSize: 16,
              // ),
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
            // obscureText: loginViewModel.getObsecureText,
            controller: passwordController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Password',
              // hintStyle: GoogleFonts.roboto(
              //   fontWeight: FontWeight.w400,
              //   fontSize: 16,
              // ),
              // suffixIcon: IconButton(
              //   icon: Icon(
              //     getObsecureText ? Icons.visibility_off : Icons.visibility,
              //   ),
              //   onPressed: () {
              //     loginViewModel.setTogglePasswordVisibility(!getObsecureText);
              //   },
              // ),
              hintText: 'Masukkan Password',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
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
                    const Color(0xFF0E6927),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Bentuk border
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                },
                child: !loading
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
