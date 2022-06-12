// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/state_managment/item_state.dart';
import 'package:weave_marketplace/widgets/image_from_network.dart';

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
      height: size.height * 0.45,
      decoration: const BoxDecoration(
        color: Color(0x0F2F2F20),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            onPageChanged: (value) => setState(() {
              current_image = value;
            }),
            pageSnapping: true,
            itemCount: itemState.item!.images!.length,
            itemBuilder: (ctx, index) => Hero(
              tag: widget.heroTag!,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                child: ImageFromNetwork(
                  itemState.item!.images![index],
                  height: size.height * 0.45,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          if (itemState.item!.images!.length > 1)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              // padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(itemState.item!.images!.length),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> indicators(imagesLength) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: current_image == index ? MAIN_COLOR : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}
