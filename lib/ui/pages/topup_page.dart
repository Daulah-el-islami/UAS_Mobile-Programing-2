import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  String accountNumber = "Loading...";
  String name = "Loading...";
  String selectedBank = "Bank BCA";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            accountNumber =
                userDoc["accountNumber"]?.toString() ?? "Tidak tersedia";
            name = userDoc["name"]?.toString() ?? "Tidak tersedia";
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        accountNumber = "Error loading data";
        name = "Error loading data";
      });
    }
  }

  void selectBank(String bankName) {
    setState(() {
      selectedBank = bankName;
    });
  }

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
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                "assets/img_wallet.png",
                width: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountNumber,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    name,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 40),
          Text(
            "Bank",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => selectBank("Bank BCA"),
            child: BankItem(
              title: "Bank BCA",
              imageUrl: "assets/img_bank_bca.png",
              isSelected: selectedBank == "Bank BCA",
            ),
          ),
          GestureDetector(
            onTap: () => selectBank("Bank BNI"),
            child: BankItem(
              title: "Bank BNI",
              imageUrl: "assets/img_bank_bni.png",
              isSelected: selectedBank == "Bank BNI",
            ),
          ),
          GestureDetector(
            onTap: () => selectBank("Bank Mandiri"),
            child: BankItem(
              title: "Bank Mandiri",
              imageUrl: "assets/img_bank_mandiri.png",
              isSelected: selectedBank == "Bank Mandiri",
            ),
          ),
          GestureDetector(
            onTap: () => selectBank("Bank OCBC"),
            child: BankItem(
              title: "Bank OCBC",
              imageUrl: "assets/img_bank_ocbc.png",
              isSelected: selectedBank == "Bank OCBC",
            ),
          ),
          const SizedBox(height: 12),
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
