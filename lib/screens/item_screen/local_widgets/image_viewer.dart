// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';

class ImageViewer extends StatefulWidget {
  final String? heroTag;
  const ImageViewer({required this.heroTag, Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int current_image = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemState = Provider.of<ItemState>(context, listen: false);

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: const BoxDecoration(
        color: Color(0x0F2F2F20),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Hero(
            tag: widget.heroTag!,
            child: Image.asset(
              itemState.item!.images![current_image],
              height: size.height * 0.25,
            ),
          ),
          SizedBox(
            height: size.height * 0.08,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: itemState.item!.images!.length,
              itemBuilder: (context, index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: current_image == index ? MAIN_COLOR : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: () => setState(() => current_image = index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      itemState.item!.images![index],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
