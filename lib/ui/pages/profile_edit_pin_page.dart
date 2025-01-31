import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({super.key});

  @override
  _ProfileEditPinPageState createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> _updatePin() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User not logged in")));
        return;
      }

      // Verify the current PIN with the one in Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final currentPin = userDoc.data()?['pin'];
        if (currentPin == _currentPinController.text) {
          // Update the PIN in Firestore
          await _firestore.collection('users').doc(user.uid).update({
            'pin': _newPinController.text,
          });

          // Navigate to success status page
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/profile-edit-status",
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Current PIN is incorrect")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User not found")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: const AppBarHeader(
        title: "Edit Pin",
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 24,
        ),
        children: [
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
                  label: "Current PIN",
                  obscureText: true,
                  maxLength: 6,
                  controller: _currentPinController,
                ),
                const SizedBox(
                  height: 16,
                ),
                InputForm(
                  label: "New Pin",
                  obscureText: true,
                  maxLength: 6,
                  controller: _newPinController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: "Update Now",
                  onPressed: _updatePin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
