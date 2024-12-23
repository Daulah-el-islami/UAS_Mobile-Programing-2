import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class TopupPage extends StatelessWidget {
  const TopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: const AppBarHeader(
        title: "Isi Ulang",
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        children: [
          Text(
            "Dompet",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                "assets/img_wallet.png",
                width: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "0857 8640 4992",
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Daulah El Islami",
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "Bank",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const BankItem(
            title: "Bank BCA",
            imageUrl: "assets/img_bank_bca.png",
            isSelected: true,
          ),
          const BankItem(
            title: "Bank BNI",
            imageUrl: "assets/img_bank_bni.png",
          ),
          const BankItem(
            title: "Bank Mandiri",
            imageUrl: "assets/img_bank_mandiri.png",
          ),
          const BankItem(
            title: "Bank OCBC",
            imageUrl: "assets/img_bank_ocbc.png",
          ),
          const SizedBox(
            height: 12,
          ),
          CustomFilledButton(
            title: "Lanjutkan",
            onPressed: () {
              Navigator.pushNamed(context, "/topup-amount");
            },
          ),
        ],
      ),
    );
  }
}
