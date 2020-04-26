import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 全螢幕
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        child: HookBuilder(
          builder: (context) {
            Stream<int> stream = buildUseMemoized();
            AsyncSnapshot<int> snapshot = useStream(stream);
            return Stack(alignment: Alignment.center, children: <Widget>[
              Image.asset('assets/icon_background.png', fit: BoxFit.fill),
              Column(children: <Widget>[
                Expanded(child: Container(), flex: 12),
                Expanded(child: buildContainer(snapshot), flex: 68),
                Expanded(child: Container(), flex: 40),
              ]),
            ]);
          },
        ),
      ),
    );
  }

  Container buildContainer(AsyncSnapshot<int> snapshot) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('鍛鍊',
                style: new TextStyle(color: Color(0xFF000000), fontSize: 50.0)),
            SizedBox(height: 20.0),
            Text('${conversionTime(snapshot.data ?? 60)}',
                style: new TextStyle(color: Color(0xFF000000), fontSize: 80.0)),
          ]),
    );
  }

  Stream<int> buildUseMemoized() {
    return useMemoized(
      () => Stream<int>.periodic(const Duration(seconds: 1), (i) {
        return i < 60 ? 60 - (i + 1) : 0;
      }),
    );
  }

  String conversionTime(int number) {
    return number >= 10 ? '00︰$number' : '00︰0$number';
  }
}
