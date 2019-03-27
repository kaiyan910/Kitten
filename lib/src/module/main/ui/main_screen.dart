import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kitten/src/module/main/bloc/main_bloc.dart';
import 'package:kitten/src/module/search/bloc/search_bloc_provider.dart';
import 'package:kitten/src/module/search/ui/search_list_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: bloc.selectedIndex,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Scaffold(
            body: SearchBlocProvider(
                child: SearchListScreen()
            ),
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
              onTap: (index) => bloc.updateSelectedIndex(index),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();

    bloc.dispose();
  }
}
