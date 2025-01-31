import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class SignUpStatusPage extends StatelessWidget {
  const SignUpStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Akun Berhasil\nTerdaftar",
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
              "Bergabunglah Dengan Kami\nAgar Anda Cepat Kaya",
              textAlign: TextAlign.center,
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              title: "Masuk",
              width: 185,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/sign-in",
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
