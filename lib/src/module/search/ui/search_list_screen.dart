import 'package:flutter/material.dart';
import 'package:kitten/src/module/search/bloc/search_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:kitten/src/common/widget/ripple_grid.dart';
import 'package:kitten/src/core/network/model/cat.dart';

class SearchListScreen extends StatefulWidget {

  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {

  final _bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    print('[DEBUG] build SearchListScreen');

    return RefreshIndicator(
      child: StreamBuilder<List<Cat>>(
        stream: _bloc.searchResult,
        initialData: List<Cat>(),
        builder: (BuildContext context, AsyncSnapshot<List<Cat>> snapshot) {
          return GridView.count(
            crossAxisCount: 3,
            physics: AlwaysScrollableScrollPhysics(),
            children: List.generate(snapshot.data.length, (index) {
              return RippleGrid(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeroPhotoViewWrapper(
                        imageProvider:
                        NetworkImage(snapshot.data[index].url),
                      ),
                    ));
              }, size, snapshot.data[index].url);
            }),
          );
        },
      ),
      displacement: 80,
      onRefresh: () => _bloc.search(),
    );
  }

  @override
  void initState() {

    _bloc.search();
    super.initState();
  }

  @override
  void dispose() {

    _bloc.dispose();
    super.dispose();
  }
}

class HeroPhotoViewWrapper extends StatelessWidget {

  HeroPhotoViewWrapper(
      {this.imageProvider,
      this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale});

  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent
      ),
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        loadingChild: loadingChild,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroTag: "someTag",
      ),
    );
  }
}
