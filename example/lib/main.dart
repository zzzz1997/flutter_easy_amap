import 'package:flutter/material.dart';
import 'package:flutter_easy_amap/flutter_easy_amap.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Amap Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Easy Amap Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AmapLocation _amapLocation;

  @override
  void initState() {
    super.initState();

    _initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(_amapLocation.toString() ?? 'error'),
      ),
    );
  }

  _initPage() async {
    Util.requestPermission(Permission.AccessFineLocation)
        .then((isAllowed) async {
      if (isAllowed) {
        AmapLocation amapLocation = await FlutterEasyAmap.getLocation();
        setState(() {
          _amapLocation = amapLocation;
        });
      } else {
        Util.showPermissionDialog(context, '我们需要定位权限取得定位信息');
      }
    });
  }
}
