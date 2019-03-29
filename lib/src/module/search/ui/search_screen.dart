import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:kitten/src/common/widget/platform_indicator.dart';

import 'package:kitten/src/module/image/ui/image_screen.dart';
import 'package:kitten/src/module/search/bloc/search_bloc.dart';
import 'package:kitten/src/common/widget/ripple_grid.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    print('[DEBUG] build SearchScreen');

    return RefreshIndicator(

      child: StreamBuilder<SearchScreenState>(
        stream: _bloc.searchResult,
        initialData: SearchScreenState.initial(),
        builder:
            (BuildContext context, AsyncSnapshot<SearchScreenState> snapshot) {

          if (!snapshot.data.init) {
            return PlatformIndicator(
              android: Center(
                child: CircularProgressIndicator(),
              ),
              ios: Center(
                child: CupertinoActivityIndicator(animating: true),
              ),
            );
          }

          return GridView.count(
            crossAxisCount: 3,
            physics: AlwaysScrollableScrollPhysics(),
            children: List.generate(snapshot.data.results.length, (index) {
              return RippleGrid(() async {
                _bloc.changeStatusBarStyle(
                    Colors.black, StatusBarStyle.LIGHT_CONTENT);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(snapshot.data.results[index]),
                  ),
                );

                _bloc.changeStatusBarStyle(
                    Colors.white, StatusBarStyle.DARK_CONTENT);
              }, size, snapshot.data.results[index].url);
            }),
          );
        },
      ),
      displacement: 50,
      onRefresh: () => _bloc.search(),
    );
  }

  @override
  void initState() {
    print('[DEBUG] initState()');
    _bloc.search();
    _bloc.changeStatusBarStyle(Colors.white, StatusBarStyle.DARK_CONTENT);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
