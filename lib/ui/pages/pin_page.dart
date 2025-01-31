import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:bank_sat/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final TextEditingController inputController = TextEditingController(text: "");
  String storedPin = ""; // Default empty pin value
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getPinFromFirestore();
  }

  // Fetch PIN from Firestore using the current user's UID
  Future<void> _getPinFromFirestore() async {
    try {
      await Firebase.initializeApp();
      User? user = _auth.currentUser; // Get the current authenticated user
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          setState(() {
            storedPin =
                doc['pin']; // Assuming the document contains a field 'pin'
          });
        }
      }
    } catch (e) {
      print("Error fetching PIN: $e");
    }
  }

  addPin(String number) {
    if (inputController.text.length < 6) {
      setState(() {
        inputController.text = inputController.text + number.toString();
      });
    }
    if (inputController.text == storedPin) {
      // Use the fetched PIN here
      Navigator.pop(context, true);
    }
  }

  deletePin() {
    if (inputController.text.isNotEmpty) {
      setState(() {
        String textValue = inputController.text;
        inputController.text = textValue.substring(0, textValue.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize(context);
    double padHorizontal = 58;
    double gap = 40;

    return Screen(
      backgroundColor: darkBgColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padHorizontal,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Masukan PIN",
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              SizedBox(
                width: screenSize.width - padHorizontal * 2,
                child: TextFormField(
                  enabled: false,
                  controller: inputController,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIconColor: greenColor,
                    contentPadding: const EdgeInsets.only(right: -24),
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
                  ),
                  style: whiteTextStyle.copyWith(
                    fontSize: 36,
                    fontWeight: medium,
                    letterSpacing: 16,
                  ),
                  textAlign: TextAlign.center,
                  obscuringCharacter: "*",
                ),
              ),
              const SizedBox(
                height: 66,
              ),
              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  CustomInputButton(
                    title: "1",
                    onTap: () {
                      addPin("1");
                    },
                  ),
                  CustomInputButton(
                    title: "2",
                    onTap: () {
                      addPin("2");
                    },
                  ),
                  CustomInputButton(
                    title: "3",
                    onTap: () {
                      addPin("3");
                    },
                  ),
                  CustomInputButton(
                    title: "4",
                    onTap: () {
                      addPin("4");
                    },
                  ),
                  CustomInputButton(
                    title: "5",
                    onTap: () {
                      addPin("5");
                    },
                  ),
                  CustomInputButton(
                    title: "6",
                    onTap: () {
                      addPin("6");
                    },
                  ),
                  CustomInputButton(
                    title: "7",
                    onTap: () {
                      addPin("7");
                    },
                  ),
                  CustomInputButton(
                    title: "8",
                    onTap: () {
                      addPin("8");
                    },
                  ),
                  CustomInputButton(
                    title: "9",
                    onTap: () {
                      addPin("9");
                    },
                  ),
                  const SizedBox(
                    width: 60,
                    height: 60,
                  ),
                  CustomInputButton(
                    title: "0",
                    onTap: () {
                      addPin("0");
                    },
                  ),
                  CustomInputButton(
                    onTap: () {
                      deletePin();
                    },
                    contentWidget: Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
