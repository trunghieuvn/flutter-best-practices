import 'dart:ui';

class ContainerData {
  int clickedCount;
  Color color;

  ContainerData(this.clickedCount, this.color);

  ContainerData.copyFrom(ContainerData data) {
    clickedCount = data.clickedCount;
    color = data.color;
  }
}
