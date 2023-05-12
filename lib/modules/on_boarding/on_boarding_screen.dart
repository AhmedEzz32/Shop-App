import 'package:flutter/material.dart';
import 'package:project1/modules/shop_app/login/shop_login_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/network/local/cashe_helper.dart';
import 'package:project1/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/onboard_2.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/onboard_3.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
  ];

  bool isLast = false;

  void submit() {
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                }, //3shan a3rf ana wslt ll25r mneen
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    expansionFactor: 4, //almsafat aly mbenhom
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ), //da 3shan adelo design
                  count: boarding.length,
                ), //da indicator aly gamb floating 3awzo yt7rk m3 alsaf7a
                const Spacer(), //da by3ml msafa ly akhr alshasha mbenhom
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ), //da altnakool lma ttnkl mben pages
                        curve: Curves
                            .fastLinearToSlowEaseIn, //da shakl altnakol 3aml azay
                      ); //3shan 3awz at7rk mn alzorar
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem([BoardingModel? model]) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model!.image),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
