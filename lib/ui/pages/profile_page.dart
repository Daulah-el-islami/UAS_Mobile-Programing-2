import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _userName = userDoc['name'] ?? 'No Name';
          });
        }
      }
    } catch (e) {
      setState(() {
        _userName = "Error loading name";
      });
      debugPrint("Error fetching user name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: const AppBarHeader(
        title: "Profil",
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(30).copyWith(bottom: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    image: const DecorationImage(
                      image: AssetImage("assets/img_profile.png"),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: greenColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  _userName,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ProfileMenuItem(
                  iconUrl: "assets/ic_edit_profile.png",
                  title: "Edit Profil",
                  onTap: () async {
                    if (await Navigator.pushNamed(context, "/pin") == true) {
                      Navigator.pushNamed(context, "/profile-edit");
                    }
                  },
                ),
                ProfileMenuItem(
                  iconUrl: "assets/ic_pin.png",
                  title: "Ubah PIN",
                  onTap: () async {
                    if (await Navigator.pushNamed(context, "/pin") == true) {
                      Navigator.pushNamed(context, "/profile-edit-pin");
                    }
                  },
                ),
                ProfileMenuItem(
                  iconUrl: "assets/ic_wallet.png",
                  title: "Pengaturan Dompet",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: "assets/ic_reward.png",
                  title: "Hadiah Saya",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: "assets/ic_help.png",
                  title: "Pusat Bantuan",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  iconUrl: "assets/ic_logout.png",
                  title: "Keluar",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 90,
          ),
          CustomTextButton(
            title: "Laporkan Masalah",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
