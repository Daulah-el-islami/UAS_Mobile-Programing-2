import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            width: 155,
            height: 50,
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 100,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/img_logo_light.png",
                ),
              ),
            ),
          ),
          Text(
            "Masuk &\nSaatnya Anda Menjadi Kaya",
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
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
                  label: "Email",
                ),
                const SizedBox(
                  height: 16,
                ),
                const InputForm(
                  label: "Kata Sandi",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Lupa Kata Sandi?",
                    style: blueTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: 'Masuk',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/home",
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextButton(
            title: "Buat Akun Baru",
            onPressed: () {
              Navigator.pushNamed(context, "/sign-up");
            },
          ),
        ],
      ),
    );
  }
}
