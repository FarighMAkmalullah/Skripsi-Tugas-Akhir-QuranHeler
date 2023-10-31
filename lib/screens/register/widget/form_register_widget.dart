import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isChecked = false;

  String gender = 'Laki - laki';

  final formKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // obscureText: loginViewModel.getObsecureText,
            controller: nameController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
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
              hintText: 'Maukkan Nama Lengkap',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
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
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // obscureText: loginViewModel.getObsecureText,
            controller: confirmPasswordController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
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
              hintText: 'Masukkan Password Lagi',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
          const Text('Gender'),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: const Color(0xFF777070),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        gender = 'Laki - laki';
                      });
                    },
                    child: Container(
                      height: 50,
                      color: gender == 'Laki - laki'
                          ? Colors.blue
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          'Laki - laki',
                          style: TextStyle(
                            color: gender == 'Laki - laki'
                                ? Colors.white
                                : const Color(0xFF777070),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        gender = 'Perempuan';
                      });
                    },
                    child: Container(
                      color: gender == 'Perempuan'
                          ? Colors.blue
                          : Colors.transparent,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Perempuan',
                          style: TextStyle(
                            color: gender == 'Perempuan'
                                ? Colors.white
                                : const Color(0xFF777070),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7.0),
          Row(
            children: <Widget>[
              SizedBox(
                width: 24,
                child: Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              const Text(
                'I Agree with Terms and Condition',
                // style: GoogleFonts.roboto(
                //   fontWeight: FontWeight.w500,
                //   fontSize: 14,
                // ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
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
                        'Register',
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
