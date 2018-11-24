import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

class Util {
  ///
  /// 请求权限
  ///
  static Future<bool> requestPermission(Permission permission) async {
    // 检查权限
    bool isAllowed = await SimplePermissions.checkPermission(permission);
    // 权限未被允许
    if (!isAllowed) {
      // 请求权限
      PermissionStatus permissionStatus =
          await SimplePermissions.requestPermission(permission);
      print(permissionStatus);
      // 权限未被允许
      if (permissionStatus != PermissionStatus.authorized) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  ///
  /// 弹出权限弹窗
  ///
  static Future<void> showPermissionDialog(context, content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('权限错误'),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('取消')),
              FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await SimplePermissions.openSettings();
                  },
                  child: Text('前往设置'))
            ],
          );
        });
    return null;
  }
}
