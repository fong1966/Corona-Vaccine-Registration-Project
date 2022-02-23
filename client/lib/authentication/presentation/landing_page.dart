import 'dart:ffi';

import 'package:covid_vaccination/app/presentation/components/error_dialogue.dart';
import 'package:covid_vaccination/authentication/presentation/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';

import 'admin_login_page.dart';
import 'components/hover_text_button.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    HoverTextButton(
                      text: 'Login',
                      fontSize: 17,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserLoginPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    HoverTextButton(
                      text: 'Admin panel',
                      fontSize: 17,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Covid Vaccine Registration',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1.5),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                buildLeftPanel(context),
                Lottie.asset(
                  'assets/lottie/prevent_epidemic.json',
                  frameRate: FrameRate(10),
                ),
                const SizedBox(height: 0),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserLoginPage(),
                      ),
                    );
                  },
                  child: Ink(
                    height: 82,
                    width: 342,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset('assets/png/injection.png'),
                            const SizedBox(width: 32),
                            Text(
                              'APPLY NOW!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildLeftPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'APPLY FOR VACCINATION',
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.9,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Let’s fight corona,\nTogether!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: 1.5,
          ),
        ),
        Image.asset(
          'assets/png/underline.png',
          filterQuality: FilterQuality.high,
        ),
      ],
    );
  }
}
