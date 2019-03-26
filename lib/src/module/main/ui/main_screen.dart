import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kitten/src/module/main/bloc/MainBloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[Text('CENTER')],
        ),
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: bloc.selectedIndex,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('Home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.business), title: Text('Business')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.school), title: Text('School'))
              ],
              currentIndex: snapshot.data,
              onTap: (index) => bloc.updateSelectedIndex(index),
            );
          }),
    );
  }

  @override
  void dispose() {

    super.dispose();

    bloc.dispose();
  }

}
