import 'package:flutter/material.dart';
import 'package:kitten/src/common/widget/ripple_grid.dart';
import 'package:kitten/src/core/network/model/cat.dart';
import 'package:kitten/src/module/favourite/bloc/favourite_bloc_provider.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = FavouriteBlocProvider.of(context);
    final size = MediaQuery.of(context).size.width / 3;

    return StreamBuilder<List<Cat>>(
      stream: bloc.favourites,
      initialData: List<Cat>(),
      builder: (BuildContext context, AsyncSnapshot<List<Cat>> snapshot) {
        return GridView.count(
          crossAxisCount: 3,
          physics: AlwaysScrollableScrollPhysics(),
          children: List.generate(snapshot.data.length, (index) {
            return RippleGrid(() => {}, size, snapshot.data[index].url);
          }),
        );
      },
    );
  }
}
