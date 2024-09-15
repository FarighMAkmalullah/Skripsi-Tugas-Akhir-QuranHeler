// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/services/edit_password/edit_password_service.dart';

// ignore: must_be_immutable
class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({
    super.key,
  });

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _showHasilEdit(bool value) async {
    if (value) {
      return const Column(
        children: [Text('Berhasil')],
      );
    } else {
      return const Column(
        children: [Text('Gagal')],
      );
    }
  }

  bool loading = false;

  bool getObsecureText = true;

  bool getObsecureTextConfirmation = true;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    @override
    void dispose() {
      passwordController.dispose();
      confirmPasswordController.dispose();
      super.dispose();
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        _showCancelDialog(context);
      },
      child: SafeArea(
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
                        _showCancelDialog(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const Text('Edit Profil'),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        var res = await EditPasswordService().postEditPassword(
                          newPassword: passwordController.text,
                        );
                        setState(() {
                          loading = false;
                        });

                        if (res.containsKey('result') && res != null) {
                          return showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: CircleAvatar(
                                              radius: 100,
                                              backgroundColor:
                                                  Color(0xFF10AB6A),
                                              child: Icon(
                                                Icons.check,
                                                size: 70,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('Data Berhasil Diubah'),
                                        ],
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomBar(
                                                    dashboardIndex: 0,
                                                    currentIndex: 3,
                                                  ),
                                                ),
                                                (route) => false);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                          ),
                                          child: const Text('Kembali')),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (res.containsKey('error') && res != null) {
                          return showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
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
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('Sepertinya ada kesalahan'),
                                        ],
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                          ),
                                          child: const Text('Coba Lagi')),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: !loading
                          ? const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              !loading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: getObsecureText,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value != null && value.length < 5) {
                                      return 'Masukkan min. 5 karakter';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        getObsecureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          getObsecureText = !getObsecureText;
                                        });
                                      },
                                    ),
                                    hintText: 'Maukkan Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: getObsecureTextConfirmation,
                                  controller: confirmPasswordController,
                                  validator: (value) {
                                    if (value != null &&
                                        value.length < 5 &&
                                        value != passwordController.text) {
                                      return 'Masukkan Confirm Password sesuai dengan Password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    prefixIcon:
                                        const Icon(Icons.lock_reset_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        getObsecureTextConfirmation
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          getObsecureTextConfirmation =
                                              !getObsecureTextConfirmation;
                                        });
                                      },
                                    ),
                                    hintText: 'Masukkan Confirm Password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomBar(
                        dashboardIndex: 0,
                        currentIndex: 2,
                      ),
                    ),
                    (route) => false);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
