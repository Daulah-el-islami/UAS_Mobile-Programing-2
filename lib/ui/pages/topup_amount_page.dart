import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:bank_sat/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopupAmoutPage extends StatefulWidget {
  const TopupAmoutPage({super.key});

  @override
  State<TopupAmoutPage> createState() => _TopupAmoutPageState();
}

class _TopupAmoutPageState extends State<TopupAmoutPage> {
  final TextEditingController inputController =
      TextEditingController(text: "0");

  // Function to get balance from Firestore
  Future<int> getCurrentBalance() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User not logged in");
        return 0;
      }

      String userId = user.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot['balance'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print("Error getting balance: $e");
      return 0;
    }
  }

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
          int.tryParse(text.replaceAll(".", "")) ?? 0,
        ),
      );
    });
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

  Future<void> updateBalance(int amount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User not logged in");
        return;
      }

      String userId = user.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Get current balance
      DocumentSnapshot snapshot = await userDocRef.get();
      if (snapshot.exists) {
        // Handle balance as double, and then convert to int if needed
        double currentBalance =
            (snapshot['balance'] ?? 0).toDouble(); // Convert to double
        double newBalance = currentBalance + amount;

        // Update the balance in Firestore
        await userDocRef.update({'balance': newBalance});
        print("Balance successfully updated: $newBalance");
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
              int amount = int.tryParse(inputController.text
                      .replaceAll(".", "")
                      .replaceAll("Rp", "")
                      .trim()) ??
                  0;

              // Update balance in Firestore
              await updateBalance(amount);

              // Navigate to next page
              if (await Navigator.pushNamed(context, "/pin") == true) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/topup-status",
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
          )
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
