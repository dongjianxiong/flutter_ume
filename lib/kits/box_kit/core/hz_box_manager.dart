
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ume/core/pluggable.dart';

import '../box_kit.dart';

const iconData =
    r'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';

final iconBytes = base64Decode(iconData);


class HzBoxManager implements Pluggable{

  Function(Map<Type, Map<String, dynamic>>? changeInfo)? _onFinish;

  /// 初始化方法,
  ///
  /// @param providers 选择需要配置的HzBoxBaseProvider子类型，HzBoxBaseProvider是个mixin, 默认全部
  ///
  static Future initWithProviders({required List<HzBoxBaseProvider> providers}) async {
    await HzBoxSharedPref.init();
    _providers.addAll(providers);
    print('HzBoxKit:===================init providers:$_providers======================');
  }

  /// 展示全局浮层按钮
  ///
  /// @param context
  /// @param onFinish 完成回调，回调参数changeInfo是配置变化信息
  ///
  static showEnterButton(BuildContext context, {Function(Map<Type, Map<String, dynamic>>? changeInfo)? onFinish,}) async {
    OverFloatWidget.show(context, onTap: (BuildContext childContext){
      showConfigPage(childContext, onFinish:onFinish);
    });
  }

  /// 展示配置列表
  ///
  /// @param context
  /// @param onFinish 完成回调，回调参数changeInfo是配置变化信息
  ///
  static showConfigPage(BuildContext context, {Function(Map<Type, Map<String, dynamic>>? changeInfo)? onFinish,}){
    HzBoxConfigWidget.show(
      context,
      providers: _providers,
      onSelected: (provider, HzBoxConfigItem item){
        provider.currentItem = item;
      },
      onFinish: (){
        _save();
        Map<Type, Map<String, dynamic>> changeInfo = {
        };
        for (var provider in _providers) {
          changeInfo[provider.runtimeType] = {
            'didChanged': provider.didChanged,
            'oldValue': provider.oldValue,
            'newValue': provider.currentValue,
          };
          if(provider.didChanged) {
            provider.onValueChanged?.call(provider.currentValue);
          }
        }
        print('HzBoxKit:======Config change info: $changeInfo========');
        onFinish?.call(changeInfo);
      },
    );
  }

  /// 插入自定义provider
  ///
  /// @param provider provider是HzBoxBaseProvider的子类， HzBoxBaseProvider是mixin
  ///
  static void insertProvider(HzBoxBaseProvider provider){
    print('HzBoxKit:======insert provider:$provider====');
    _providers.add(provider);
  }

  static List<HzBoxBaseProvider> get providers => _providers;

  /// ---------- private -----------
  static final List<HzBoxBaseProvider> _providers = [];

  static _save() async {
    for (var provider in _providers) {
      provider.save();
      print('HzBoxKit:=======value:${provider.currentValue}==========');
    }
  }

  @override
  Widget? buildWidget(BuildContext? context) {

    return HzBoxConfigWidget(providers: HzBoxManager.providers,
      onSelected: (provider, item){
        provider.currentItem = item;
        provider.save();
        provider.onValueChanged?.call(provider.currentValue);
      },
      onFinish: (){
        _save();
        Map<Type, Map<String, dynamic>> changeInfo = {};
        for (var provider in _providers) {
          changeInfo[provider.runtimeType] = {
            'didChanged': provider.didChanged,
            'oldValue': provider.oldValue,
            'newValue': provider.currentValue,
          };
          if(provider.didChanged) {
            provider.onValueChanged?.call(provider.currentValue);
          }
        }
        print('HzBoxKit:======Config change info: $changeInfo========');
        _onFinish?.call(changeInfo);
      },
    );
  }

  @override
  String get displayName => 'HzBoxKit';

  @override
  // TODO: implement iconImageProvider
  ImageProvider<Object> get iconImageProvider =>  MemoryImage(iconBytes);

  @override
  // TODO: implement name
  String get name => 'HzBoxKit';

  @override
  void onTrigger() {
  }
}