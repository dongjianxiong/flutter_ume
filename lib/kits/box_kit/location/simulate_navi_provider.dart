
import '../box_kit.dart';

class SimulatedNaviProvider with HzBoxBaseProvider<bool> {

  static bool value = false;

  SimulatedNaviProvider(){
    bool ret = HzBoxSharedPref.getValueForKey('HzBoxEnableSimulatedNavigation') ?? false;
    currentItem = HzBoxConfigItem<bool>(
      type: ret,
      title: ret ? '开启模拟导航' : '关闭模拟导航',
    );
    SimulatedNaviProvider.value = ret;
  }

  @override
  void save({HzBoxConfigItem<bool>? newItem}) {
    if(newItem != null) {
      currentItem = newItem;
    }
    SimulatedNaviProvider.value = currentValue;
    HzBoxSharedPref.saveValueForKey(currentValue, 'HzBoxEnableSimulatedNavigation');
  }

  @override
  List<HzBoxConfigItem<bool>> get itemList {
    return [
      HzBoxConfigItem<bool>(
        type: true,
        title: '开启模拟导航',
      ),
      HzBoxConfigItem<bool>(
        type: false,
        title: '关闭模拟导航',
      ),
    ];
  }

  @override
  String get title => '是否开启模拟导航';

  @override
  bool get currentValue => currentItem?.type ?? SimulatedNaviProvider.value;


  // save() async{
  //   SharedPreferences preferences =  await SharedPreferences.getInstance();
  //   preferences.setBool('HzBoxEnableSimulatedNavigation', enableSimulatedNavigation);
  // }
  //
  // static read() async{
  //   SharedPreferences preferences =  await SharedPreferences.getInstance();
  //   enableSimulatedNavigation = preferences.getBool('HzBoxEnableSimulatedNavigation') ?? false;
  // }
  //
  // static HzBoxConfigModel<bool> configModel() {
  //   return HzBoxConfigModel<bool>(
  //     configType: HzBoxConfigType.simulatedNav,
  //     title: '是否开启模拟导航',
  //     currentValue: HzBoxConfigItem<bool>(
  //       type: enableSimulatedNavigation,
  //       title: enableSimulatedNavigation ? '开启模拟导航' : '关闭模拟导航',
  //     ),
  //     itemList: _itemList,
  //   );
  // }
  //
  //
  // static final List<HzBoxConfigItem<bool>> _itemList = [
  //   HzBoxConfigItem<bool>(
  //     type: true,
  //     title: '开启模拟导航',
  //   ),
  //   HzBoxConfigItem<bool>(
  //     type: false,
  //     title: '关闭模拟导航',
  //   ),
  // ];
}