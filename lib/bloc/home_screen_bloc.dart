import 'dart:async';
import 'package:flutter_test_app/models/container_data.dart';
import 'package:flutter_test_app/screens/home/__mock__/card_data_mock.dart';

enum HomeScreenState {
  none,
  loading,
}

class HomeScreenBloc {
  //state
  StreamController<HomeScreenState> _blocController;
  HomeScreenState globalState = HomeScreenState.loading;
  Stream<HomeScreenState> get itemStream => _blocController.stream;

  StreamController<int> _containerController;
  int currentSelectedIdx = 0;
  Stream<int> get containerStream => _containerController.stream;
  List<ContainerObserverble> containerObserDatas;

  HomeScreenBloc() {
    _blocController = StreamController.broadcast();
    _containerController = StreamController.broadcast();

    containerObserDatas = CardDataMock.containerObserDatas;
  }

  void initData() {
    changeHomeScreenState(HomeScreenState.none);
  }

  void changeHomeScreenState(HomeScreenState state) {
    if (!_blocController.isClosed) {
      globalState = state;
      _blocController.sink.add(globalState);
    }
  }

  void changeContainerState(int idx) {
    if (!_containerController.isClosed) {
      currentSelectedIdx = idx;
      _containerController.sink.add(currentSelectedIdx);
    }
  }

  void dispose() {
    _blocController?.close();
    _containerController?.close();
    containerObserDatas.map((item) => {item.dispose()});
  }
}
