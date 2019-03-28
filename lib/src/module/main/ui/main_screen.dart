import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kitten/generated/i18n.dart';

import 'package:kitten/src/module/favourite/ui/favourite_screen.dart';
import 'package:kitten/src/module/main/bloc/main_bloc.dart';
import 'package:kitten/src/module/search/ui/search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] build MainScreen');

    return StreamBuilder<int>(
      stream: _bloc.selectedIndex,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            centerTitle: true,
            title: Text(
              S.of(context).app_name,
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          body: _buildBody(snapshot.data),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_a_photo), title: Text(S.of(context).main_bs_gallery)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), title: Text(S.of(context).main_bs_favourite)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text(Localizations.localeOf(context).toString()),
              ),
            ],
            currentIndex: snapshot.data,
            onTap: (index) => _bloc.updateSelectedIndex(index),
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

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return SearchScreen();
      case 1:
        return FavouriteScreen();
      default:
        return SearchScreen();
    }
  }
}
