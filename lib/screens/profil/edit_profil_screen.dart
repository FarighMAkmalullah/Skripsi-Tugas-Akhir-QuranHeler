import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isChecked = false;

  String gender = 'Laki - laki';

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const Text('Edit Profil'),
                  const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFD9DCE1),
                    radius: 100,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text('Ubah Foto')),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
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
                            if (email != null &&
                                !EmailValidator.validate(email)) {
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
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
