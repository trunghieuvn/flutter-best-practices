import 'package:flutter/material.dart';
import 'package:flutter_test_app/controllers/home/container_observerble.dart';
import 'package:flutter_test_app/models/container_data.dart';

class CardDataMock {
  static List<ContainerController> containerObserDatas = [
    ContainerController(ContainerData(0, Colors.red)),
    ContainerController(ContainerData(0, Colors.blue)),
    ContainerController(ContainerData(0, Colors.green)),
    ContainerController(ContainerData(0, Colors.grey)),
    ContainerController(ContainerData(0, Colors.greenAccent)),
    ContainerController(ContainerData(0, Colors.redAccent)),
    ContainerController(ContainerData(0, Colors.pink)),
    ContainerController(ContainerData(0, Colors.pinkAccent)),
    ContainerController(ContainerData(0, Colors.purple)),
    ContainerController(ContainerData(0, Colors.purpleAccent)),
    ContainerController(ContainerData(0, Colors.deepOrange))
  ];
}
