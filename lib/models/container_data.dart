
import 'dart:async';
import 'dart:ui';

class ContainerData {
  int clickedCount;
  Color color;

  ContainerData(
    this.clickedCount, 
    this.color
  );

  ContainerData.copyFrom(ContainerData data) {
    clickedCount  = data.clickedCount;
    color         = data.color;
  }
}

class ContainerObserverble {
  StreamController<ContainerData> _controller;
  ContainerData data;

  ContainerObserverble(this.data) {
    _controller = StreamController.broadcast();
  }

  Stream get getStream => _controller.stream;

  void notifidataChanged(ContainerData data) {
    if(!_controller.isClosed) {
      this.data = data;
      _controller.sink.add(data);
    }
  }

  void dispose() {
    _controller.close();
  }
}