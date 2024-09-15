// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/profil/edit_profil_view_model.dart';
import 'package:quranhealer/services/edit_profil/edit_profil_service.dart';

// ignore: must_be_immutable
class EditProfilScreen extends StatefulWidget {
  String namaLengkap;
  String email;
  String gender;
  EditProfilScreen({
    super.key,
    required this.namaLengkap,
    required this.email,
    required this.gender,
  });

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    EditProfilViewModel editProfilScreen =
        Provider.of<EditProfilViewModel>(context);
    editProfilScreen.setEmailController(widget.email);
    editProfilScreen.setNameController(widget.namaLengkap);
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

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    EditProfilViewModel editProfilScreen =
        Provider.of<EditProfilViewModel>(context);

    // ignore: unused_element
    @override
    void dispose() {
      editProfilScreen.emailController;
      editProfilScreen.nameController;
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
                        if (formKey.currentState!.validate()) {
                          editProfilScreen.setLoading(true);
                          var res = await EditProfilService().postEditProfil(
                            name: editProfilScreen.nameController.text,
                            email: editProfilScreen.emailController.text,
                            gender: editProfilScreen.gender,
                          );
                          editProfilScreen.setLoading(false);

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
                                                      currentIndex: 2,
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
                        }
                      },
                      child: !editProfilScreen.loading
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
              !editProfilScreen.loading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: widget.gender == 'L'
                              ? Image.asset(
                                  "assets/images/chat/chat-account-user.png",
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  "assets/images/chat/chat-account-userp.png",
                                  fit: BoxFit.contain,
                                ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
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
                                  // obscureText: loginViewModel.getObsecureText,
                                  controller: editProfilScreen.nameController,
                                  validator: (value) {
                                    if (value != null && value.length < 5) {
                                      return 'Enter min. 5 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Nama Lengkap',
                                    prefixIcon: Icon(Icons.perm_identity),
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: editProfilScreen.emailController,
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
                                    prefixIcon: Icon(Icons.email),
                                    // hintStyle: GoogleFonts.roboto(
                                    //   fontWeight: FontWeight.w400,
                                    //   fontSize: 16,
                                    // ),
                                    hintText: 'Masukkan Email',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
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
                                            editProfilScreen.setGender('L');
                                          },
                                          child: Container(
                                            height: 50,
                                            color:
                                                editProfilScreen.gender == 'L'
                                                    ? Colors.blue
                                                    : Colors.transparent,
                                            child: Center(
                                              child: Text(
                                                'Laki - laki',
                                                style: TextStyle(
                                                  color: editProfilScreen
                                                              .gender ==
                                                          'L'
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
                                            editProfilScreen.setGender('P');
                                          },
                                          child: Container(
                                            color:
                                                editProfilScreen.gender == 'P'
                                                    ? Colors.blue
                                                    : Colors.transparent,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                'Perempuan',
                                                style: TextStyle(
                                                  color: editProfilScreen
                                                              .gender ==
                                                          'P'
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
                        currentIndex: 3,
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
