import 'dart:async';

import 'package:flutter/services.dart';

class FlutterEasyAmap {
  static const MethodChannel _channel =
      const MethodChannel('flutter_easy_amap');

  static Future<AmapLocation> getLocation() async {
    var map = await _channel.invokeMethod('getLocation');
    return AmapLocation.fromMap(map);
  }
}

class AmapLocation {
  final String address;
  final String province;
  final String city;
  final String district;

  AmapLocation({this.address, this.province, this.city, this.district});

  static AmapLocation fromMap(map) {
    return AmapLocation(
      address: map['address'],
      province: map['province'],
      city: map['city'],
      district: map['district']
    );
  }

  @override
  String toString() {
    return '''
    address:$address
    province:$province
    city:$city
    district:$district
    ''';
  }
}