import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

abstract class IPermissionsService implements IDisposable {
  static IPermissionsService of(BuildContext context, {bool listen = true}) =>
      Provider.of<IPermissionsService>(context, listen: listen);

  Future<PermissionStatus> checkPermissionStatus(Permission permission);

  Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> list,
  );
}
