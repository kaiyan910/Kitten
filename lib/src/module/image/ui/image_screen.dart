import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitten/generated/i18n.dart';
import 'package:kitten/src/common/widget/platform_loading.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/module/image/bloc/image_bloc.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {
  final Cat cat;

  ImageScreen(this.cat, {Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final _bloc = ImageBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ImageState>(
      stream: _bloc.imageState,
      initialData: ImageState.initial(),
      builder: (BuildContext context, AsyncSnapshot<ImageState> snapshot) {
        if (snapshot.data.showSnackBar) {
          _showSnackBar(context);
        }

        return Stack(
          children: <Widget>[
            _buildPhotoView(snapshot.data.downloading),
            _buildAppBar(),
            _buildBottomFavourite(snapshot.data.favourite),
          ],
        );
      },
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

  Widget _buildPhotoView(bool showLoading) => Stack(
        children: <Widget>[
          PhotoView(
            imageProvider: NetworkImage(widget.cat.url),
            initialScale: 1.0,
            minScale: 0.5,
            heroTag: widget.cat.url,
          ),
          Center(
            child: PlatformLoading(
              showLoading: showLoading,
            ),
          ),
        ],
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
              onPressed: () => _bloc.share(widget.cat.url, S.of(context).share_message),
            ),
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () => _bloc.download(widget.cat.url),
            ),
          ],
        ),
      );

  Widget _buildBottomFavourite(bool favourite) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(
              (favourite) ? Icons.favorite : Icons.favorite_border,
              color: (favourite) ? Colors.red : Colors.white,
            ),
            onPressed: () =>
                _bloc.changeFavouriteStatus(widget.cat, !favourite),
          ),
        ),
      );

  _showSnackBar(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      final snackBar = SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          S.of(context).settings_downloaded,
          style: TextStyle(color: Colors.white),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
}
