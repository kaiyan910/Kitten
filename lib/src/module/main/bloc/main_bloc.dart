import 'package:rxdart/rxdart.dart';

class MainBloc {

  final _bottomNavIndexFetcher = PublishSubject<int>();
  final _bottomNavIndex = BehaviorSubject<int>();

  Observable<int> get selectedIndex => _bottomNavIndex.stream;
  Function(int) get updateSelectedIndex => _bottomNavIndexFetcher.sink.add;

  MainBloc() {

    _bottomNavIndexFetcher
        .stream
        .pipe(_bottomNavIndex);
  }

  dispose() async {

    _bottomNavIndexFetcher.close();
    await _bottomNavIndex.drain();
    _bottomNavIndex.close();
  }
}