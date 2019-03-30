import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef void OnGridTapListener(ImageProvider provider);

class RippleGrid extends StatelessWidget {
  final OnGridTapListener onTap;
  final double size;
  final String url;

  RippleGrid(this.onTap, this.size, this.url);

  @override
  Widget build(BuildContext context) {

    ImageProvider imageProvider = CachedNetworkImageProvider(url);

    return Hero(
      tag: url,
      child: Stack(
        children: <Widget>[
          FadeInImage(
            placeholder: AssetImage("assets/images/placeholder.png"),
            image: imageProvider,
            fit: BoxFit.cover,
            height: size,
            width: size,
          ),
          Material(
              color: Colors.transparent,
              child: new InkWell(
                splashColor: Colors.white30,
                onTap: () => onTap(imageProvider),
              )),
        ],
      ),
    );
  }
}
