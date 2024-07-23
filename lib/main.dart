import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'nRTJhACuSyuH0l09fBiJqeyoAVN4gAg9DPCPmxEz';
  const keyClientKey = 'm51KfFDw5qbQuseS6vCIeQVpdeqx6rfnKG58EDMS';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
  );
  runApp(const MyApp());
}
