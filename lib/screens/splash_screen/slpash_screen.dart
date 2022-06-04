import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: MediaQuery.of(context).size.width * 0.7,
            // ),
            const SizedBox(height: 20),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
