import 'package:flutter/material.dart';
import 'package:kitten/src/module/favourite/bloc/favourite_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final bloc = FavouriteBloc();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
