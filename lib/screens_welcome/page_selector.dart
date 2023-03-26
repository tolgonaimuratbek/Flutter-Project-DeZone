import 'package:de_zone/components/reusable__widgets_generall.dart';
import 'package:flutter/material.dart';
import '../screens_welcome/welcome_learn.dart';
import '../screens_welcome/welcome_practise.dart';
import '../screens_welcome/welcome_help.dart';
import '../constants.dart';
import '../screens_login_registration/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({Key? key}) : super(key: key);
  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    //dot indicators
                    child: Column(children: <Widget>[
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: const WormEffect(
                          activeDotColor: kColourBlueMain,
                          dotColor: kColourGreyMain,
                          dotHeight: 12,
                          dotWidth: 12,
                          spacing: 6,
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: PageView(
                          controller: _controller,
                          children: [
                            WelcomeLearn(),
                            WelcomePractise(),
                            WelcomeHelp(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      reusableBottomButton(context, 'Los geht\'s', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      })
                    ])))));
  }
}
