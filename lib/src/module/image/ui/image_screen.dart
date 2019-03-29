import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/module/image/bloc/image_bloc.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {

  final Cat cat;

  ImageScreen(this.cat,
      {Key key})
      : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  final _bloc = ImageBloc();

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        _buildPhotoView(),
        _buildAppBar(),
        _buildBottomFavourite(),
      ],
    );
  }

  @override
  void initState() {
    _bloc.checkFavourite(widget.cat.id);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildPhotoView() => PhotoView(
    imageProvider: NetworkImage(widget.cat.url),
    initialScale: 1.0,
    minScale: 0.5,
    heroTag: widget.cat.url,
  );

  Widget _buildAppBar() => Positioned(
    top: 0.0,
    left: 0.0,
    right: 0.0,
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      brightness: Brightness.dark,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, "OK"),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.file_download),
          onPressed: () => _bloc.download(widget.cat.url),
        ),
      ],
    ),
  );

  Widget _buildBottomFavourite() => StreamBuilder(
    stream: _bloc.favourite,
    initialData: false,
    builder: (BuildContext context, AsyncSnapshot<bool> favourite) {
      return Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(
              (favourite.data) ? Icons.favorite : Icons.favorite_border,
              color: (favourite.data) ? Colors.red : Colors.white,
            ),
            onPressed: () => _bloc.changeFavouriteStatus(widget.cat, !favourite.data),
          ),
        ),
      );
    },
  );
}
