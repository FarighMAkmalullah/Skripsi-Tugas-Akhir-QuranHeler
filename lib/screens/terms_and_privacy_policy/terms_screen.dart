import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.note),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45),
            child: Center(
              child: Image.asset(
                'assets/logo/logo2.png',
                height: 140,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Terms and Conditions (Syarat dan Ketentuan',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Selamat datang di QuranHealer, sebuah aplikasi yang dirancang untuk membantu Anda dalam menjalani kehidupan yang lebih baik dan penuh makna melalui penggunaan fitur-fitur berikut:',
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "1. Penggunaan Aplikasi",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "a. Dengan mengunduh dan menggunakan aplikasi QuranHealer, Anda setuju untuk mematuhi semua ketentuan dan persyaratan dalam Syarat dan Ketentuan ini.",
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  "b. Anda bertanggung jawab penuh atas penggunaan aplikasi ini, dan Anda tidak akan menggunakan aplikasi ini untuk tujuan yang melanggar hukum atau merugikan pihak lain.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "2. Autentikasi",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "a. Untuk menggunakan fitur-fitur tertentu dalam aplikasi, Anda harus membuat akun pengguna. Data pribadi yang Anda berikan saat pendaftaran akan dijaga sesuai dengan Kebijakan Privasi kami.",
                  textAlign: TextAlign.justify,
                ),
                const Text(
                  "b. Anda bertanggung jawab untuk menjaga kerahasiaan informasi login Anda dan tidak boleh membagikannya kepada pihak lain.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "3. Jadwal Adzan",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "a. Fitur jadwal adzan disediakan sebagai referensi dan panduan untuk waktu ibadah. Kami tidak bertanggung jawab atas ketidakakuratan atau perubahan jadwal yang mungkin terjadi.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "4. Al-Quran dan Doa Pilihan",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "a. Aplikasi ini menyediakan akses ke Al-Quran dan berbagai doa pilihan. Pengguna bertanggung jawab atas penggunaan materi ini dan diharapkan untuk mematuhi aturan dan etika yang sesuai.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "5. Hak Cipta",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "a. Semua konten dalam aplikasi, termasuk teks Al-Quran dan doa-doa, adalah hak cipta dilindungi oleh undang-undang. Pengguna tidak diperkenankan untuk menggandakan, mendistribusikan, atau mempublikasikan konten tersebut tanpa izin.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF486AE1),
                    ),
                    onPressed: () {},
                    child: const Text('Tentang Kami'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
