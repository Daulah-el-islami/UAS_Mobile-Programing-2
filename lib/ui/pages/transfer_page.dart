import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String selectedUser = "";

  void selectUser(String userName) {
    setState(() {
      selectedUser = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: const AppBarHeader(
        title: "Kirim",
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 24,
        ),
        children: [
          Text(
            "Cari",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const InputForm(
            hints: "",
          ),
          buildRecentUsers(),
          const SizedBox(
            height: 20,
          ),
          CustomFilledButton(
            title: "Lanjutkan",
            onPressed: () {
              Navigator.pushNamed(context, "/transfer-amount");
            },
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget buildRecentUsers() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pengguna Terbaru",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          GestureDetector(
            onTap: () => selectUser("Siti Saadah"),
            child: TransferRecentUserItem(
              imageUrl: "assets/img_friend1.png",
              name: "Siti Saadah",
              username: "siti",
              isVerified: false,
              isSelected: selectedUser == "Siti Saadah",
            ),
          ),
          GestureDetector(
            onTap: () => selectUser("Eulis Juha"),
            child: TransferRecentUserItem(
              imageUrl: "assets/img_friend2.png",
              name: "Eulis Juha",
              username: "eulis",
              isVerified: true,
              isSelected: selectedUser == "Eulis Juha",
            ),
          ),
          GestureDetector(
            onTap: () => selectUser("Epul Bedog"),
            child: TransferRecentUserItem(
              imageUrl: "assets/img_friend3.png",
              name: "Epul Bedog",
              username: "epul",
              isVerified: true,
              isSelected: selectedUser == "Epul Bedog",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hasil",
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Wrap(
            spacing: 17,
            runSpacing: 17,
            children: [
              TransferResultItem(
                imageUrl: "assets/img_friend1.png",
                name: "Siti Saadah",
                username: "siti",
                isVerified: false,
                isSelected: false,
              ),
              TransferResultItem(
                imageUrl: "assets/img_friend2.png",
                name: "Eulis Juha",
                username: "eulis",
                isVerified: true,
                isSelected: true,
              ),
              TransferResultItem(
                imageUrl: "assets/img_friend3.png",
                name: "Epul Bedog",
                username: "epul",
                isVerified: true,
                isSelected: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
