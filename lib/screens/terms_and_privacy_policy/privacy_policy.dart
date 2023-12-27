import 'package:flutter/material.dart';

class PrivacyPolicyScreem extends StatefulWidget {
  const PrivacyPolicyScreem({super.key});

  @override
  State<PrivacyPolicyScreem> createState() => _PrivacyPolicyScreemState();
}

class _PrivacyPolicyScreemState extends State<PrivacyPolicyScreem> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Kebijakan Privasi"),
          Text(
              "Kami sangat menghargai privasi Anda dan berkomitmen untuk melindungi informasi pribadi Anda. Kebijakan Privasi kami menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi data pribadi Anda. Di sini adalah poin-poin penting dari Kebijakan Privasi kami:"),
          Text("1. Pengumpulan Data"),
          Text(
              "a. Kami dapat mengumpulkan informasi pribadi yang Anda berikan saat mendaftar atau menggunakan aplikasi."),
          Text("2. Penggunaan Data"),
          Text(
              "a. Kami menggunakan data pribadi Anda untuk mengoperasikan dan meningkatkan layanan kami, serta memberikan konten yang relevan."),
          Text("3. Berbagi Data"),
          Text(
              "a. Kami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga tanpa izin Anda, kecuali jika diperlukan oleh hukum."),
          Text("4. Keamanan Data"),
          Text(
              "a. Kami menjaga standar keamanan tertinggi untuk melindungi data pribadi Anda dari akses yang tidak sah atau perubahan."),
          Text("5. Akses dan Pilihan"),
          Text(
              "a. Anda memiliki hak untuk mengakses dan memperbarui data pribadi Anda. Anda juga dapat memilih untuk menghapus akun Anda kapan saja."),
        ],
      ),
    );
  }
}
