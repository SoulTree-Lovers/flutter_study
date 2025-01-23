import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final flutterSecureStorage = FlutterSecureStorage();

final emulatorIp = '10.0.2.2:3000'; // 안드로이드 에뮬레이터에서 localhost로 접근하기 위한 IP
final simulatorIp = '127.0.0.1:3000'; // iOS 시뮬레이터에서 localhost로 접근하기 위한 IP

final ip = Platform.isIOS ? simulatorIp : emulatorIp; // 플랫폼에 따라 IP 설정
