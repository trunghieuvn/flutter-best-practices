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

  StreamController<int> _listContainerController;
  Stream<int> get listContainerStream => _listContainerController.stream;

  //data
  List<ContainerData> containerDatas = [
    ContainerData(0, Colors.amber),
    ContainerData(0, Colors.blue),
    ContainerData(0, Colors.green),
    ContainerData(0, Colors.grey),
    ContainerData(0, Colors.greenAccent),
    ContainerData(0, Colors.redAccent),
    ContainerData(0, Colors.pink),
    ContainerData(0, Colors.pinkAccent),
    ContainerData(0, Colors.purple),
    ContainerData(0, Colors.purpleAccent),
    ContainerData(0, Colors.deepOrange),
  ];

  HomeScreenBloc() {
    _blocController = StreamController.broadcast();
    _containerController = StreamController.broadcast();
    _listContainerController = StreamController.broadcast();
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

  void updateList(int idx) {
    if (!_containerController.isClosed) {
      _listContainerController.sink.add(idx);
    }
  }

  void dispose() {
    _blocController?.close();
    _containerController?.close();
    _listContainerController?.close();
  }
}
