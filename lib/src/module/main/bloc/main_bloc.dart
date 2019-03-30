import 'package:kitten/src/core/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BaseBloc {
  final _bottomNavIndexFetcher = PublishSubject<int>();
  final _bottomNavIndex = BehaviorSubject<int>();

  Observable<int> get selectedIndex => _bottomNavIndex.stream;

  Function(int) get updateSelectedIndex => _bottomNavIndexFetcher.sink.add;

  MainBloc() {
    _bottomNavIndexFetcher.stream.pipe(_bottomNavIndex);
  }

  @override
  dispose() async {
    _bottomNavIndexFetcher.close();
    await _bottomNavIndex.drain();
    _bottomNavIndex.close();
  }
}
