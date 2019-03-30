import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:kitten/generated/i18n.dart';
import 'package:kitten/src/common/widget/platform_loading.dart';
import 'package:kitten/src/core/database/local_repository.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/module/image/bloc/image_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {
  final Cat cat;
  final ImageProvider imageProvider;

  ImageScreen(this.cat, this.imageProvider, {Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState(
      ImageBloc(kiwi.Container().resolve<LocalRepository>(), cat));
}

class _ImageScreenState extends State<ImageScreen> {
  final ImageBloc _bloc;

  _ImageScreenState(this._bloc);

  @override
  Widget build(BuildContext context) {
    _bloc.changeStatusBarStyle(Colors.black, StatusBarStyle.LIGHT_CONTENT);
    return StreamBuilder<ImageState>(
      stream: _bloc.imageState,
      initialData: ImageState.initial(),
      builder: (BuildContext context, AsyncSnapshot<ImageState> snapshot) {
        print("[DEBUG] _ImageScreen ${snapshot.data}");

        if (snapshot.data.showSnackBar) {
          _showSnackBar(context, snapshot.data.hasError);
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                _buildPhotoView(context, snapshot.data.downloading),
                _buildAppBar(context, _bloc),
                _buildBottomFavourite(_bloc, snapshot.data.favourite),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildPhotoView(BuildContext context, bool showLoading) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          PhotoView(
            //CachedNetworkImageProvider(_cat.url),
            minScale: PhotoViewComputedScale.contained,
            imageProvider: widget.imageProvider,
            maxScale: 2.0,
            heroTag: widget.cat.url,
          ),
          Center(
            child: PlatformLoading(
              showLoading: showLoading,
            ),
          ),
        ],
      );

  Widget _buildAppBar(BuildContext context, ImageBloc bloc) => Positioned(
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
              onPressed: () =>
                  bloc.share(widget.cat.url, S.of(context).share_message),
            ),
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () => bloc.download(widget.cat.url),
            ),
          ],
        ),
      );

  Widget _buildBottomFavourite(ImageBloc bloc, bool favourite) => Positioned(
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
            onPressed: () => bloc.changeFavouriteStatus(widget.cat, !favourite),
          ),
        ),
      );

  void _showSnackBar(BuildContext context, bool hasError) {
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      final snackBar = SnackBar(
        backgroundColor: (hasError) ? Colors.red : Colors.blue,
        duration: Duration(milliseconds: 500),
        content: Text(
          (hasError)
              ? S.of(context).settings_download_error
              : S.of(context).settings_downloaded,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
}