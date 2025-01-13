import 'hz_box_config_item.dart';

mixin HzBoxBaseProvider<T> {

  T? _oldValue;

  /// 标题
  String get title;
  /// 保存配置
  void save({HzBoxConfigItem<T>? newItem});
  /// 旧值
  T? get oldValue => _oldValue;
  /// 新值
  T get currentValue;
  /// 是否已经变更
  bool get didChanged{
    return oldValue != currentValue;
  }

  Function(T value)? onValueChanged;

  /// 配置选项
  List<HzBoxConfigItem<T>> get itemList;

  /// 选中选项
  HzBoxConfigItem<T>? _currentItem;
  set currentItem (HzBoxConfigItem<T>? item) {
    _oldValue = item?.type;
    _currentItem = item;
    print('HzBoxKit:=======save value:${currentItem?.type}==========');
  }
  HzBoxConfigItem<T>? get currentItem => _currentItem;

  /// 当前值下标
  int get currentIndex {
    int index = -1;
    for (int i = 0; i< itemList.length; i++) {
      HzBoxConfigItem<T> item = itemList[i];
      if(item.type == currentItem?.type) {
        index = i;
        break;
      }
    }
    return index;
  }
}