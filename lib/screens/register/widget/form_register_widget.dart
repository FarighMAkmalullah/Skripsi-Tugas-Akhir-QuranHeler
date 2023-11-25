import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/register/register_view_mode.dart';
import 'package:quranhealer/services/register/register_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);

    @override
    void dispose() {
      registerViewModel.confirmPasswordController;
      registerViewModel.emailController;
      registerViewModel.nameController;
      registerViewModel.passwordController;
      super.dispose();
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: registerViewModel.nameController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              hintText: 'Maukkan Nama Lengkap',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: registerViewModel.emailController,
            validator: (email) {
              if (email != null && !EmailValidator.validate(email)) {
                return 'Enter a valid email';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Masukkan Email',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: registerViewModel.passwordController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Masukkan Password',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: registerViewModel.confirmPasswordController,
            validator: (value) {
              if (value != null && value.length < 5) {
                return 'Enter min. 5 characters';
              } else if (value != registerViewModel.passwordController.text) {
                return 'Password didn\'t match';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
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
                      registerViewModel.setGender('L');
                    },
                    child: Container(
                      height: 50,
                      color: registerViewModel.gender == 'L'
                          ? Colors.blue
                          : Colors.transparent,
                      child: Center(
                        child: Text(
                          'Laki - laki',
                          style: TextStyle(
                            color: registerViewModel.gender == 'L'
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
                      registerViewModel.setGender('P');
                    },
                    child: Container(
                      color: registerViewModel.gender == 'P'
                          ? Colors.blue
                          : Colors.transparent,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Perempuan',
                          style: TextStyle(
                            color: registerViewModel.gender == 'P'
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
                  value: registerViewModel.isChecked,
                  onChanged: (value) {
                    registerViewModel.setChecked(value!);
                  },
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              const Text(
                'I Agree with Terms and Condition',
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
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (registerViewModel.isChecked == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You need to accept the terms')));
                  } else if (formKey.currentState!.validate() &&
                      registerViewModel.isChecked == true) {
                    formKey.currentState!.save();

                    registerViewModel.setLoading(true);
                    var res = await RegisterService().postRegister(
                      name: registerViewModel.nameController.text,
                      email: registerViewModel.emailController.text,
                      gender: registerViewModel.gender,
                      password: registerViewModel.passwordController.text,
                    );
                    registerViewModel.penggantiDispose();

                    print(res);

                    if (res.containsKey('result') && res != null) {
                      // =============================================================
                      // ignore: use_build_context_synchronously
                      return showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              SizedBox(
                                height: 350,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: 300,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          const Text(
                                            "Success",
                                            style: TextStyle(
                                              color: Color(0xFF10AB6A),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text(
                                              "Yeeey..., Akunmu Berhasil Dibuat"),
                                          const Text(
                                              'Yuk login biar bisa masuk ke aplikasi QuranHealer'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          FractionallySizedBox(
                                            widthFactor: 1,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  const Color(0xFF0E6927),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5), // Bentuk border
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, '/login');
                                              },
                                              child: const Text('Login'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        radius: 100,
                                        backgroundColor: Color(0xFF10AB6A),
                                        child: Icon(
                                          Icons.check,
                                          size: 70,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (res.containsKey('error') && res != null) {
                      if (res['error'] == "data sudah ada") {
                        // ignore: use_build_context_synchronously
                        return showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                SizedBox(
                                  height: 350,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        height: 300,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 20),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            const Text(
                                              "Failed",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                                "Akunmu sudah terdaftar di QuranHealer"),
                                            const Text(
                                                'Yuk login biar bisa masuk ke aplikasi QuranHealer'),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: 1,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    const Color(0xFF0E6927),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5), // Bentuk border
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/login');
                                                },
                                                child: const Text('Login'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: CircleAvatar(
                                            radius: 100,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.close,
                                              size: 70,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (res['error'] ==
                          '"email" must be a valid email') {
                        // ignore: use_build_context_synchronously
                        return showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                SizedBox(
                                  height: 350,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        height: 300,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 20),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            const Text(
                                              "Failed",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                                "Sepertinya ada kesalahan pada email saat mendaftarkan"),
                                            const Text('Coba daftar lagi...'),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: 1,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    const Color(0xFF0E6927),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5), // Bentuk border
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Daftar'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CircleAvatar(
                                          radius: 100,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            size: 70,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        return showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Stack(
                              children: [
                                SizedBox(
                                  height: 350,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        height: 300,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 20),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            const Text(
                                              "Failed",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                                "Yah.. Sepertinya ada kesalahan."),
                                            const Text('Coba daftar lagi...'),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: 1,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    const Color(0xFF0E6927),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5), // Bentuk border
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Daftar'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CircleAvatar(
                                          radius: 100,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            size: 70,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      // ignore: use_build_context_synchronously
                      return showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              SizedBox(
                                height: 350,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: 300,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          )),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          const Text(
                                            "Failed",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text(
                                              "Yah.. Sepertinya ada kesalahan."),
                                          const Text('Coba daftar lagi...'),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          FractionallySizedBox(
                                            widthFactor: 1,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  const Color(0xFF0E6927),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5), // Bentuk border
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Daftar'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        radius: 100,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: 70,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: !registerViewModel.loading
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
