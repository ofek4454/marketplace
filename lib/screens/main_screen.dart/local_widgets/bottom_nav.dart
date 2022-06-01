// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int? current_page;
  final Function? change_page;
  const BottomNav({this.current_page, this.change_page, Key? key})
      : super(key: key);

  Widget _build_btn(IconData icon, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () => change_page!(index),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: current_page == index ? Colors.black : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: current_page == index ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          _build_btn(Icons.home_outlined, 0),
          _build_btn(Icons.favorite_border, 1),
          const Spacer(),
          _build_btn(Icons.person_outlined, 2),
        ],
      ),
    );
  }
}
