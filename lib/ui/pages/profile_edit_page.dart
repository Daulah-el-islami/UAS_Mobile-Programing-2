import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: const AppBarHeader(
        title: "Edit Profil",
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 24,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputForm(
                  label: "Nama Pengguna",
                ),
                const SizedBox(
                  height: 16,
                ),
                const InputForm(
                  label: "Nama Lengkap",
                ),
                const SizedBox(
                  height: 16,
                ),
                const InputForm(
                  label: "Alamat Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                const InputForm(
                  label: "Kata Sandi",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: "Perbarui Sekarang",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/profile-edit-status",
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
