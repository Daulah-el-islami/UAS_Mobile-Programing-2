import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: loadThemeData(),
      routes: {
        "/": (context) => const SplashPage(),
        "/onboarding": (context) => const OnBoardingPage(),
        "/sign-in": (context) => const SignInPage(),
        "/sign-up": (context) => const SignUpPage(),
        "/sign-up-status": (context) => const SignUpStatusPage(),
        "/home": (context) => const HomePage(),
        "/profile": (context) => const ProfilePage(),
        "/pin": (context) => const PinPage(),
        "/profile-edit": (context) => const ProfileEditPage(),
        "/profile-edit-pin": (context) => const ProfileEditPinPage(),
        "/profile-edit-status": (context) => const ProfileEditStatusPage(),
        "/topup": (context) => const TopupPage(),
        "/topup-amount": (context) => const TopupAmoutPage(),
        "/topup-status": (context) => const TopupStatusPage(),
        "/transfer": (context) => const TransferPage(),
        "/transfer-amount": (context) => const TransferAmoutPage(),
        "/transfer-status": (context) => const TransferStatusPage(),
      },
    );
  }
}
