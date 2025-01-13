import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ume/kits/channel_monitor/src/core/ume_binary_messenger.dart';

class ChannelBinding extends WidgetsFlutterBinding {
  static WidgetsBinding? ensureInitialized() {
    return WidgetsBinding.instance;
  }

  @override
  @protected
  // 替换 BinaryMessenger
  BinaryMessenger createBinaryMessenger() {
    return UmeBinaryMessenger.binaryMessenger;
  }
}
