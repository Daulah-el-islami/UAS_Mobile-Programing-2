import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _generateRandomAccountNumber(int length) {
    const chars = '0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _signUp() async {
    try {
      // 1. Create a user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. Generate random account number with 16 digits
      String accountNumber = _generateRandomAccountNumber(16);

      // 3. Save user data to Firestore with balance initialized to 0
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'createdAt': Timestamp.now(),
        'accountNumber': accountNumber,
        'pin': _pinController.text.trim(),
        'balance': 0, // Menambahkan saldo awal 0
      });

      // 4. Navigate to the sign-up status page after successful registration
      Navigator.pushNamed(context, '/sign-up-status');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

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
            "Bergabunglah\nSupaya Anda Cepat Kaya",
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputForm(
                  label: "Nama",
                  controller: _nameController,
                ),
                const SizedBox(height: 16),
                InputForm(
                  label: "Email",
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                InputForm(
                  label: "Kata Sandi",
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                InputForm(
                  label: "Atur PIN (6 digit angka)",
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: _pinController,
                ),
                const SizedBox(height: 30),
                CustomFilledButton(
                  onPressed: _signUp,
                  title: 'Lanjutkan',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
