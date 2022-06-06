// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/models/auth_model.dart';
import 'package:weave_marketplace/models/user_model.dart';
import 'package:weave_marketplace/screens/login_screen/login_screen.dart';
import 'package:weave_marketplace/screens/main_screen.dart/main_screen.dart';
import 'package:weave_marketplace/screens/splash_screen/slpash_screen.dart';
import 'package:weave_marketplace/services/streams.dart';
import 'package:weave_marketplace/state_managment/basket_state.dart';
import 'package:weave_marketplace/state_managment/marketplace_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

enum AuthStatus {
  NotLoggedIn,
  LoggedIn,
  Unknown,
}

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.Unknown;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final _auth = Provider.of<AuthModel>(context);
    if (_auth.uid != null) {
      setState(() {
        _authStatus = AuthStatus.LoggedIn;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.NotLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.NotLoggedIn:
        return const LoginScreen();
      case AuthStatus.LoggedIn:
        final _auth = Provider.of<AuthModel>(context);

        return MultiProvider(
          providers: [
            StreamProvider<UserState>.value(
              value: DBStreams().getCurrentUser(_auth.uid!),
              initialData: UserState(UserModel()),
            ),
            ChangeNotifierProvider<MarketPlaceState>(
              create: (context) => MarketPlaceState(),
            ),
            ChangeNotifierProvider<BasketState>(
              create: (context) => BasketState(),
            ),
          ],
          child: const MainScreen(),
        );
      case AuthStatus.Unknown:
        return const SplashScreen();
      default:
        return const SplashScreen();
    }
  }
}
