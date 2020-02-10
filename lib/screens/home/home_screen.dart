import 'package:flutter/material.dart';

import 'package:flutter_test_app/bloc/home_screen_bloc.dart';
import 'package:flutter_test_app/common/widgets/card_widget.dart';
import 'package:flutter_test_app/models/container_data.dart';
import 'package:flutter_test_app/screens/home/home_constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _bloc;

  @override
  void initState() {
    _bloc = HomeScreenBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<HomeScreenState>(
        stream: _bloc.itemStream,
        initialData: _bloc.globalState,
        builder: (context, snapshot) {
          if (snapshot == null ||
              snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == HomeScreenState.loading) {
            _bloc.initData();
            return _buidLoading();
          }

          return SafeArea(child: _buildMainHome());
        },
      ),
    );
  }

  Widget _buidLoading() {
    return Center(
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _buildMainHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _bloc.containerObserDatas
                  .asMap()
                  .map(
                    (i, container) => MapEntry(
                      i,
                      StreamBuilder<ContainerData>(
                        stream: _bloc.containerObserDatas[i].getStream,
                        initialData: _bloc.containerObserDatas[i].data,
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CardWidget(
                              key: Key(
                                '${HomeConstants.buttonContainerListKey}$i',
                              ),
                              height: HomeConstants.cardHeigth,
                              width: HomeConstants.cardWidth,
                              bgColors: [data.color, data.color],
                              borderRadius: 0,
                              text: data.clickedCount.toString(),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                              onPressed: () {
                                _bloc.changeContainerState(i);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder<int>(
          stream: _bloc.containerStream,
          initialData: _bloc.currentSelectedIdx,
          builder: (context, snapshotIdx) {
            final idx = snapshotIdx.data;
            return StreamBuilder<ContainerData>(
              stream: _bloc.containerObserDatas[idx].getStream,
              initialData: _bloc.containerObserDatas[idx].data,
              builder: (context, snapshot) {
                final containerData = _bloc.containerObserDatas[idx].data;
                return CardWidget(
                  key: const Key(HomeConstants.buttonContainerDetailKey),
                  height: HomeConstants.cardWidth * 1.2,
                  width: HomeConstants.cardWidth * 1.2,
                  bgColors: [containerData.color, containerData.color],
                  borderRadius: 0,
                  text: containerData.clickedCount.toString(),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  onPressed: () {
                    containerData.clickedCount++;
                    _bloc.containerObserDatas[idx].notifidataChanged(
                      ContainerData.copyFrom(containerData),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
