import 'package:flutter/material.dart';
import 'package:kitten/src/core/bloc/app_bloc.dart';
import 'package:kitten/src/core/bloc/bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AppBloc>(context);

    return StreamBuilder(
      stream: bloc.locale,
      builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            children: <Widget>[
              createLocaleInkWell("ENGLISH", snapshot.data, Locale("en", ""),
                  () => bloc.updateLocale(Locale("en", ""))),
              Divider(),
              createLocaleInkWell("正體中文", snapshot.data, Locale("zh", "HK"),
                  () => bloc.updateLocale(Locale("zh", "HK"))),
              Divider(),
              createLocaleInkWell("简体中文", snapshot.data, Locale("zh", "CN"),
                  () => bloc.updateLocale(Locale("zh", "CN"))),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget createLocaleInkWell(
      String label, Locale currentLocale, Locale locale, Function onTap) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(label),
          trailing: (currentLocale == locale)
              ? Icon(
                  Icons.done,
                  color: Colors.blue,
                )
              : Material(),
        ),
      ),
    );
  }
}
