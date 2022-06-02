// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/models/auth_model.dart';
import 'package:weave_marketplace/root.dart';
import 'package:weave_marketplace/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthModel?>.value(
      initialData: AuthModel(),
      value: Auth().userAuth,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weave',
        theme: ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: RootScreen(),
        ),
      ),
    );
  }
}
