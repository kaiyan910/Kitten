import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kitten/generated/i18n.dart';
import 'package:kitten/src/common/widget/platform_indicator.dart';
import 'package:kitten/src/core/bloc/bloc.dart';

import 'package:kitten/src/module/favourite/ui/favourite_screen.dart';
import 'package:kitten/src/module/main/bloc/main_bloc.dart';
import 'package:kitten/src/module/search/ui/search_screen.dart';
import 'package:kitten/src/module/settings/ui/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _bloc.selectedIndex,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return PlatformIndicator(
          android: _buildAndroid(context, _bloc, snapshot.data),
          ios: _buildAndroid(context, _bloc, snapshot.data),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context, MainBloc bloc, int data) {
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
      body: _buildBody(data),
      bottomNavigationBar: BottomNavigationBar(
        items: _createNavigationBarItem(context),
        currentIndex: data,
        onTap: (index) => bloc.updateSelectedIndex(index),
      ),
    );
  }

  List<BottomNavigationBarItem> _createNavigationBarItem(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.add_a_photo),
        title: Text(S.of(context).main_bs_gallery),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text(S.of(context).main_bs_favourite),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text(S.of(context).main_bs_settings),
      ),
    ];
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return SearchScreen();
      case 1:
        return FavouriteScreen();
      default:
        return SettingsScreen();
    }
  }
}
