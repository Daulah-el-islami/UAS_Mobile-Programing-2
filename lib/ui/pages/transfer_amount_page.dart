import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:bank_sat/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'package:fluttertoast/fluttertoast.dart'; // Import FlutterToast package

class TransferAmoutPage extends StatefulWidget {
  const TransferAmoutPage({super.key});

  @override
  State<TransferAmoutPage> createState() => _TransferAmoutPageState();
}

class _TransferAmoutPageState extends State<TransferAmoutPage> {
  final TextEditingController inputController =
      TextEditingController(text: "0");
  double _balance = 0.0; // Menggunakan double untuk balance

  @override
  void initState() {
    super.initState();

    inputController.addListener(() {
      final text = inputController.text;

      inputController.value = inputController.value.copyWith(
        text: NumberFormat.currency(
          locale: "id",
          decimalDigits: 0,
          symbol: "",
        ).format(
          int.parse(
            text.replaceAll(".", ""),
          ),
        ),
      );
    });

    _getBalance(); // Mendapatkan saldo awal saat halaman dibuka
  }

  // Mendapatkan saldo pengguna dari Firestore
  Future<void> _getBalance() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User not logged in");
        return;
      }

      String userId = user.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        setState(() {
          // Mengonversi balance ke double untuk menghindari error tipe
          _balance = (snapshot['balance'] is int)
              ? (snapshot['balance'] as int).toDouble()
              : snapshot['balance'] ?? 0.0;
        });
      }
    } catch (e) {
      print("Error getting balance: $e");
    }
  }

  addAmount(String number) {
    setState(() {
      String tempValue =
          inputController.text == "0" ? "" : inputController.text;
      inputController.text = tempValue + number;
    });
  }

  deleteAmount() {
    if (inputController.text.isNotEmpty) {
      setState(() {
        String textValue = inputController.text;
        String tempValue = textValue.substring(0, textValue.length - 1);

        if (tempValue.isEmpty) {
          tempValue = "0";
        }
        inputController.text = tempValue;
      });
    }
  }

  // Firestore method to update balance after transfer
  Future<void> updateBalance(double amount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User not logged in");
        return;
      }

      String userId = user.uid; // Get the user ID
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Get current balance
      DocumentSnapshot snapshot = await userDocRef.get();
      if (snapshot.exists) {
        double currentBalance = snapshot['balance'] ?? 0.0;
        if (currentBalance < amount) {
          // Tampilkan Toast jika saldo tidak cukup
          Fluttertoast.showToast(msg: "Saldo tidak cukup");
          return;
        }
        double newBalance = currentBalance - amount;

        print("Current Balance: $currentBalance");
        print("Amount Deducted: $amount");
        print("New Balance: $newBalance");

        await userDocRef.update({'balance': newBalance});
        print("Balance successfully updated");
      } else {
        print("User document not found");
      }
    } catch (e) {
      print("Error updating balance: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    double padHorizontal = 58;
    double gap = 40;

    return Screen(
      backgroundColor: darkBgColor,
      appBar: AppBarHeader(
        title: "Jumlah Total",
        titleStyle: whiteTextStyle.copyWith(
          fontSize: 20,
          fontWeight: semiBold,
        ),
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        backgroundColor: darkBgColor,
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: padHorizontal,
          vertical: 30,
        ),
        children: [
          const SizedBox(
            height: 37,
          ),
          SizedBox(
            width: screenSize.width - padHorizontal * 2,
            child: TextFormField(
              enabled: false,
              controller: inputController,
              decoration: InputDecoration(
                suffixIconColor: greenColor,
                contentPadding: const EdgeInsets.only(right: 0),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: greyColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: greyColor,
                  ),
                ),
                prefixText: "Rp.",
                prefixStyle: whiteTextStyle.copyWith(
                  fontSize: 36,
                  fontWeight: medium,
                ),
              ),
              style: whiteTextStyle.copyWith(
                fontSize: 36,
                fontWeight: medium,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(
            height: 66,
          ),
          Center(
            child: Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                ..._buildButton1to9(addAmount),
                const SizedBox(
                  width: 60,
                  height: 60,
                ),
                CustomInputButton(
                  title: "0",
                  onTap: () {
                    addAmount("0");
                  },
                ),
                CustomInputButton(
                  onTap: () {
                    deleteAmount();
                  },
                  contentWidget: Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomFilledButton(
            title: "Lanjutkan",
            onPressed: () async {
              // Parsing input untuk menghapus format dan konversi ke double
              double amount = double.parse(inputController.text
                  .replaceAll(".", "")
                  .replaceAll("Rp", "")
                  .trim());

              // Periksa saldo sebelum melakukan update
              await updateBalance(amount);

              // Navigasi ke halaman berikutnya
              if (await Navigator.pushNamed(context, "/pin") == true) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/transfer-status",
                  (route) => false,
                );
              }
            },
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextButton(
            title: "Syarat & Ketentuan",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildButton1to9(void Function(String)? addAmount) {
  int index = 0;
  List<Widget> listButton = [];

  while (index < 9) {
    String numberString = (index + 1).toString();
    listButton.add(
      CustomInputButton(
        title: numberString,
        onTap: () {
          addAmount!(numberString);
        },
      ),
    );
    index++;
  }

  return listButton;
}
