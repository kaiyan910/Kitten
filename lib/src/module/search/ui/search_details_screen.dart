import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/module/search/bloc/search_details_bloc.dart';
import 'package:photo_view/photo_view.dart';

class SearchDetailsScreen extends StatefulWidget {

  final Cat cat;

  SearchDetailsScreen(this.cat,
      {Key key})
      : super(key: key);

  @override
  _SearchDetailsScreenState createState() => _SearchDetailsScreenState();
}

class _SearchDetailsScreenState extends State<SearchDetailsScreen> {

  final _bloc = SearchDetailsBloc();

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
    minScale: 0.5,
    heroTag: widget.cat.id,
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
          onPressed: () {},
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
