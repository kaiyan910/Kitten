import 'package:flutter/material.dart';

class RippleGrid extends StatelessWidget {
  final Function onTap;
  final double size;
  final String url;

  RippleGrid(this.onTap, this.size, this.url);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: url,
      child: Stack(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder.png',
            image: url,
            fit: BoxFit.cover,
            height: size,
            width: size,
          ),
          Material(
              color: Colors.transparent,
              child: new InkWell(
                splashColor: Colors.white30,
                onTap: onTap,
              )),
        ],
      ),
    );
  }
}
