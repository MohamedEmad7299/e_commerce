import 'package:e_commerce/shared/funs.dart';
import 'package:e_commerce/ui/login/login_screen.dart';
import 'package:e_commerce/ui/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget onBoardingPage(OnBoardingModel onBoardingModel) {
  return Container(
    padding: EdgeInsets.all(16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: SvgPicture.asset(
          onBoardingModel.image,
          width: 300,
          height: 300,
        )),
        SizedBox(
          height: 16,
        ),
        Text(
          onBoardingModel.title,
          style: TextStyle(fontSize: 24, color: cabaret),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          onBoardingModel.description,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    ),
  );
}

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel(
      {required this.image, required this.title, required this.description});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  var isLast = false;

  List<OnBoardingModel> boardings = [
    OnBoardingModel(
        image: 'assets/illustrations/shopping.svg',
        title: 'Easy Shopping Experience',
        description:
            'Browse and add your favorite products to the cart with just a tap. A seamless shopping experience awaits!'),
    OnBoardingModel(
        image: 'assets/illustrations/offers.svg',
        title: 'Exclusive Deals & Offers',
        description:
            'Stay updated with the latest promotions and discounts. Never miss out on the best deals!'),
    OnBoardingModel(
        image: 'assets/illustrations/credit.svg',
        title: 'Secure & Fast Payments',
        description:
            'Enjoy hassle-free and secure transactions with multiple payment options. Your data is always safe!'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                onSkipBoarding(context, LoginScreen());
              },
              child: Text(
                'Skip',
                style: TextStyle(color: cabaret, fontSize: 18),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boardings.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (context, index) {
                    return onBoardingPage(boardings[index]);
                  },
                  itemCount: 3,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: cabaret,
                          dotHeight: 8,
                          dotWidth: 8),
                      controller: boardController,
                      count: boardings.length),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        onSkipBoarding(context, LoginScreen());
                      }
                      boardController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    backgroundColor: cabaret,
                    child: Icon(
                        color: Colors.white,
                        size: 32,
                        Icons.keyboard_arrow_right_sharp),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
