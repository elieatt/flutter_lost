import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class ItemImage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  final double? imageHeight;
  final double? imageWidth;
  final BoxFit? boxFit;

  const ItemImage(
      {Key? key,
      required this.heroTag,
      required this.imageUrl,
      this.imageHeight,
      this.imageWidth,
      this.boxFit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PinchZoomImage(
          zoomedBackgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
          hideStatusBarWhileZooming: true,
          image: CachedNetworkImage(
            filterQuality: FilterQuality.low,
            height: imageHeight,
            width: imageWidth,
            fit: boxFit ?? BoxFit.contain,
            placeholder: (context, _) {
              return SizedBox(
                child: Image.asset(
                  "assets/placeholderpng.png",
                ),
              );
            },
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}
