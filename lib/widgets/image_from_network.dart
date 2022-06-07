import 'package:flutter/material.dart';
import 'package:weave_marketplace/colors.dart';

class ImageFromNetwork extends StatelessWidget {
  String url;
  double? width, height;

  ImageFromNetwork(this.url, {this.height, this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (ctx, object, stacktrace) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      ),
      loadingBuilder: (ctx, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: CircularProgressIndicator.adaptive(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
            valueColor: const AlwaysStoppedAnimation<Color>(MAIN_COLOR),
          ),
        );
      },
    );
  }
}
