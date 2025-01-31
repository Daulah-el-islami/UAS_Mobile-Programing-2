import 'package:bank_sat/shared/theme.dart';
import 'package:bank_sat/ui/widgets/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();

  List<String> titles = [
    "Tumbuhkan\nKeuangan Anda Hari Ini",
    "Bangun Dari\nNol ke Kebebasan",
    "Mulai Bersama",
  ];

  List<String> subTitles = [
    "Sistem kami membantu Anda untuk\nmencapai tujuan yang lebih baik",
    "Kami memberikan tips agar Anda dapat\nberadaptasi dengan lebih mudah",
    "Kami akan memandu Anda ke tempat\nyang Anda tuju juga",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  'assets/img_onboarding1.png',
                  height: 331,
                ),
                Image.asset(
                  'assets/img_onboarding2.png',
                  height: 331,
                ),
                Image.asset(
                  'assets/img_onboarding3.png',
                  height: 331,
                ),
              ],
              carouselController: carouselController,
              options: CarouselOptions(
                height: 331,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    titles[currentIndex],
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    subTitles[currentIndex],
                    textAlign: TextAlign.center,
                    style: greyTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: currentIndex == 2 ? 38 : 50,
                  ),
                  currentIndex == 2
                      ? Column(
                          children: [
                            CustomFilledButton(
                              title: 'Daftar',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/sign-up",
                                  (route) => false,
                                );
                              },
                            ),
                            CustomTextButton(
                              title: 'Masuk',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/sign-in",
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            PaginationItem(
                              isActive: currentIndex == 0,
                            ),
                            PaginationItem(
                              isActive: currentIndex == 1,
                            ),
                            PaginationItem(
                              isActive: currentIndex == 2,
                            ),
                            const Spacer(),
                            CustomFilledButton(
                              title: 'Lanjutkan',
                              width: 150,
                              onPressed: () {
                                carouselController.nextPage();
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
