import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ConnectionChecker.dart';
import 'ConnectionStatusValueNotifier.dart';

class WarningWidgetValueNotifier extends StatelessWidget {
  const WarningWidgetValueNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, ConnectionStatus status, child) {
        return Visibility(
          visible: status != ConnectionStatus.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.red,
            child: Row(
              children: const [
                Icon(Icons.wifi_off, color: Colors.white),
                SizedBox(width: 8),
                Text('No hay conexión a Internet.', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }
}