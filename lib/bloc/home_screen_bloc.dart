import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/container_data.dart';

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

  //data
  List<ContainerObserverble> containerObserDatas = [
    ContainerObserverble(ContainerData(0, Colors.amber)),
    ContainerObserverble(ContainerData(0, Colors.blue)),
    ContainerObserverble(ContainerData(0, Colors.green)),
    ContainerObserverble(ContainerData(0, Colors.grey)),
    ContainerObserverble(ContainerData(0, Colors.greenAccent)),
    ContainerObserverble(ContainerData(0, Colors.redAccent)),
    ContainerObserverble(ContainerData(0, Colors.pink)),
    ContainerObserverble(ContainerData(0, Colors.pinkAccent)),
    ContainerObserverble(ContainerData(0, Colors.purple)),
    ContainerObserverble(ContainerData(0, Colors.purpleAccent)),
    ContainerObserverble(ContainerData(0, Colors.deepOrange))
  ];

  HomeScreenBloc() {
    _blocController = StreamController.broadcast();
    _containerController = StreamController.broadcast();
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
    containerObserDatas.map((item) => {
      item.dispose()
    });
  }
}
