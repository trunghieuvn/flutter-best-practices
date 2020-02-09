import 'package:flutter/material.dart';
import 'package:flutter_test_app/bloc/home_screen_bloc.dart';
import 'package:flutter_test_app/common/widgets/simple_button.dart';

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
          child: StreamBuilder<Object>(
              stream: _bloc.listContainerStream,
              initialData: _bloc.currentSelectedIdx,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _bloc.containerDatas
                      .asMap()
                      .map(
                        (i, container) => MapEntry(
                          i,
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SimpleButton(
                              height: 100,
                              width: 100,
                              bgColors: [container.color, container.color],
                              borderRadius: 0,
                              text: container.clickedCount.toString(),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                              onPressed: () {
                                _bloc.changeContainerState(i);
                              },
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                );
              }),
        ),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder<int>(
          stream: _bloc.containerStream,
          initialData: _bloc.currentSelectedIdx,
          builder: (context, snapshot) {
            final containerData = _bloc.containerDatas[snapshot.data];
            return SimpleButton(
              height: 120,
              width: 120,
              bgColors: [containerData.color, containerData.color],
              borderRadius: 0,
              text: containerData.clickedCount.toString(),
              textStyle: const TextStyle(color: Colors.white, fontSize: 30),
              onPressed: () {
                containerData.clickedCount++;
                _bloc.updateList(_bloc.currentSelectedIdx);
              },
            );
          },
        ),
      ],
    );
  }
}
