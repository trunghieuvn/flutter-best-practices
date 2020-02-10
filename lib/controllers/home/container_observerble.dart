import 'dart:async';

import 'package:flutter_test_app/models/container_data.dart';

class ContainerController {
  StreamController<ContainerData> _controller;
  ContainerData data;

  ContainerController(this.data) {
    _controller = StreamController.broadcast();
  }

  Stream get getStream => _controller.stream;

  void notifidataChanged(ContainerData data) {
    if (!_controller.isClosed) {
      this.data = data;
      _controller.sink.add(data);
    }
  }

  void dispose() {
    _controller.close();
  }
}
