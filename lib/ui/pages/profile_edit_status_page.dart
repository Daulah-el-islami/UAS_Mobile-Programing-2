import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class ProfileEditStatusPage extends StatelessWidget {
  const ProfileEditStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profil Berhasil Diperbaharui!",
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              "Data Anda Sudah Diperbaharui.",
              textAlign: TextAlign.center,
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              title: "Kembali",
              width: 185,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/home",
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
