import 'dart:async';

import 'package:etno_app/main.dart';
import 'package:etno_app/utils/ConnectionChecker.dart';
import 'package:flutter/cupertino.dart';

class ConnectionStatusValueNotifier extends ValueNotifier<ConnectionStatus>{
  late StreamSubscription _connectionSubscription;

  ConnectionStatusValueNotifier() : super(ConnectionStatus.online) {
    _connectionSubscription = internetChecker.internetStatus().listen((newStatus) => value = newStatus);
  }
  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}