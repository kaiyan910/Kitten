import 'package:rxdart/rxdart.dart';

class MainBloc {

  final _selectedIndexFetcher = PublishSubject<int>();
  final _selectedIndexOutput = BehaviorSubject<int>();

  Observable<int> get selectedIndex => _selectedIndexOutput.stream;

  Function(int) get updateSelectedIndex => _selectedIndexFetcher.sink.add;

  MainBloc() {

    _selectedIndexFetcher
        .stream
        .pipe(_selectedIndexOutput);
  }

  dispose() {

    _selectedIndexFetcher.close();
    _selectedIndexOutput.close();
  }
}