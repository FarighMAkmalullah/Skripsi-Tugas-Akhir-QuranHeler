import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Terms and Conditions (Syarat dan Ketentuan'),
          Text('Selamat datang di QuranHealer, sebuah aplikasi yang dirancang untuk membantu Anda dalam menjalani kehidupan yang lebih baik dan penuh makna melalui penggunaan fitur-fitur berikut:'),
          Text("1. Penggunaan Aplikasi"),
          Text("a. Dengan mengunduh dan menggunakan aplikasi QuranHealer, Anda setuju untuk mematuhi semua ketentuan dan persyaratan dalam Syarat dan Ketentuan ini."),
          Text("Anda bertanggung jawab penuh atas penggunaan aplikasi ini, dan Anda tidak akan menggunakan aplikasi ini untuk tujuan yang melanggar hukum atau merugikan pihak lain."),
          Text("2. Autentikasi"),
          Text("a. Untuk menggunakan fitur-fitur tertentu dalam aplikasi, Anda harus membuat akun pengguna. Data pribadi yang Anda berikan saat pendaftaran akan dijaga sesuai dengan Kebijakan Privasi kami."),
          Text("b. Anda bertanggung jawab untuk menjaga kerahasiaan informasi login Anda dan tidak boleh membagikannya kepada pihak lain."),
          Text("3. Jadwal Adzan"),
          Text("a. Fitur jadwal adzan disediakan sebagai referensi dan panduan untuk waktu ibadah. Kami tidak bertanggung jawab atas ketidakakuratan atau perubahan jadwal yang mungkin terjadi."),
          Text("4. Al-Quran dan Doa Pilihan"),
          Text("a. Aplikasi ini menyediakan akses ke Al-Quran dan berbagai doa pilihan. Pengguna bertanggung jawab atas penggunaan materi ini dan diharapkan untuk mematuhi aturan dan etika yang sesuai."),
          Text("5. Hak Cipta"),
          Text("a. Semua konten dalam aplikasi, termasuk teks Al-Quran dan doa-doa, adalah hak cipta dilindungi oleh undang-undang. Pengguna tidak diperkenankan untuk menggandakan, mendistribusikan, atau mempublikasikan konten tersebut tanpa izin."),
        ],
      ),
    );
  }
}
