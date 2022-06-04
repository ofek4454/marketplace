// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';

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

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.file(
            widget.images![current_image],
            height: size.height * 0.2,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: size.height * 0.08,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images!.length,
              itemBuilder: (context, index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          current_image == index ? Colors.amber : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: () => setState(() => current_image = index),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Image.file(
                      widget.images![index],
                      fit: BoxFit.contain,
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
