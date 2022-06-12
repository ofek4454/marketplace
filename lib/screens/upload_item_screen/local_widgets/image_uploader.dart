// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weave_marketplace/colors.dart';

class ImageUploader extends StatefulWidget {
  final Function? get_image, clear_images;
  List<File>? images;
  ImageUploader(
      {@required this.images,
      @required this.get_image,
      @required this.clear_images,
      Key? key})
      : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        GestureDetector(
          onTap: () => widget.get_image!(),
          child: Container(
            height: size.height * 0.35,
            decoration: BoxDecoration(
              color:
                  const Color.fromARGB(149, 224, 224, 224), //Color(0x0F5F5F50),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: widget.images!.isEmpty
                ? const Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 30,
                    color: MAIN_COLOR,
                  )
                : ImageViewer(widget.images),
          ),
        ),
        if (widget.images!.isNotEmpty)
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white54,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red)),
              child: IconButton(
                color: Colors.red,
                icon: const Icon(Icons.cleaning_services_rounded),
                onPressed: () => widget.clear_images!(),
                splashColor: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}

class ImageViewer extends StatefulWidget {
  List<File>? images;
  ImageViewer(this.images, {Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int current_image = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: widget.images!.length,
          onPageChanged: (index) => setState(() {
            current_image = index;
          }),
          itemBuilder: (ctx, index) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              widget.images![index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (widget.images!.length > 1)
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
              children: indicators(widget.images!.length),
            ),
          ),
      ],
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
