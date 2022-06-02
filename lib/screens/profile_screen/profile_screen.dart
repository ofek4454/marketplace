import 'package:flutter/material.dart';
import 'package:weave_marketplace/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          child: Text('Log out'),
          onPressed: () => Auth().signOut(),
          style: TextButton.styleFrom(primary: Colors.red),
        ),
      ),
    );
  }
}
