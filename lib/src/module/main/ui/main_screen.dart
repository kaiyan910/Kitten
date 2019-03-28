import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
              '喵喵',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          body: _buildBody(snapshot.data),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_a_photo), title: Text('圖片')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), title: Text('最愛')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('設定')),
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
