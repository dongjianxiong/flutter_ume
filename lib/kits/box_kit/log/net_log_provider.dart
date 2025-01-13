import '../box_kit.dart';

class NetLogProvider with HzBoxBaseProvider<bool> {
  static bool value = false;

  NetLogProvider() {
    bool ret = HzBoxSharedPref.getValueForKey('HzBoxNetLogLevelEnable') ?? false;
    currentItem = HzBoxConfigItem<bool>(
      type: ret,
      title: _title(ret),
    );
    NetLogProvider.value = ret;
  }

  @override
  void save({HzBoxConfigItem<bool>? newItem}) {
    if (newItem != null) {
      currentItem = newItem;
    }
    NetLogProvider.value = currentValue;
    HzBoxSharedPref.saveValueForKey(currentValue, 'HzBoxNetLogLevelEnable');
  }

  @override
  List<HzBoxConfigItem<bool>> get itemList {
    return [
      HzBoxConfigItem<bool>(
        type: true,
        title: _title(true),
      ),
      HzBoxConfigItem<bool>(
        type: false,
        title: _title(false),
      ),
    ];
  }

  String _title(bool isShow) {
    String title = '否';
    if (isShow) {
      title = '是';
    }
    return title;
  }

  @override
  String get title => '是否展示网络请求日志';

  @override
  bool get currentValue => currentItem?.type ?? NetLogProvider.value;
}
