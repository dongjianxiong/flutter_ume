import 'package:flutter/foundation.dart';

import '../box_kit.dart';

/// 服务端地址类型
enum ServiceEnvType {
  /// 开发环境
  dev,

  /// 测试环境
  test,

  /// 预发布环境
  preRel,

  /// 发布环境
  release,
}

class ServiceEnvProvider with HzBoxBaseProvider<ServiceEnvType> {
  static ServiceEnvType value = ServiceEnvType.release;

  ServiceEnvProvider() {
    String? name = HzBoxSharedPref.getValueForKey('HzBoxServiceEnvType');
    print('ServiceEnvProvider:===name:$name');
    name ??= ServiceEnvType.release.name;
    for (var element in ServiceEnvType.values) {
      if (element.name == name) {
        // level = element;
        currentItem = HzBoxConfigItem<ServiceEnvType>(
          type: element,
          title: _titleForType(element),
        );
        ServiceEnvProvider.value = currentValue;
      }
    }
  }

  @override
  void save({HzBoxConfigItem<ServiceEnvType>? newItem}) {
    if (newItem != null) {
      currentItem = newItem;
    }
    if (currentItem?.type != null) {
      ServiceEnvProvider.value = currentValue;
      HzBoxSharedPref.saveValueForKey(currentValue.name, 'HzBoxServiceEnvType');
    }
  }

  @override
  List<HzBoxConfigItem<ServiceEnvType>> get itemList {
    return [
      HzBoxConfigItem<ServiceEnvType>(
        type: ServiceEnvType.dev,
        title: _titleForType(ServiceEnvType.dev),
      ),
      HzBoxConfigItem<ServiceEnvType>(
        type: ServiceEnvType.test,
        title: _titleForType(ServiceEnvType.test),
      ),
      HzBoxConfigItem<ServiceEnvType>(
        type: ServiceEnvType.preRel,
        title: _titleForType(ServiceEnvType.preRel),
      ),
      HzBoxConfigItem<ServiceEnvType>(
        type: ServiceEnvType.release,
        title: _titleForType(ServiceEnvType.release),
      ),
    ];
  }

  @override
  String get title => '服务端环境配置';

  @override
  ServiceEnvType get currentValue => currentItem?.type ?? ServiceEnvProvider.value;

  String _titleForType(ServiceEnvType type) {
    String title = '';
    switch (type) {
      case ServiceEnvType.dev:
        title = '开发环境';
        break;
      case ServiceEnvType.test:
        title = '测试环境';
        break;
      case ServiceEnvType.preRel:
        title = '预发环境';
        break;
      case ServiceEnvType.release:
        title = '生产环境';
        break;
    }
    return title;
  }
}
