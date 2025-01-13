
import '../box_kit.dart';

class LocationProvider with HzBoxBaseProvider<String> {

  List<String> locations = [];
  static String value = '';

  LocationProvider(){
    String? location = HzBoxSharedPref.getValueForKey('HzBoxLocation');
    dynamic locationStringList = HzBoxSharedPref.getValueForKey('HzBoxLocationList') ?? [];
    print('ServiceEnvProvider:===location:$location, locationStringList:$locationStringList');
    for (var element in locationStringList) {
      locations.add(element);
    }
    if(location == null && locationStringList.isNotEmpty) {
      location = locationStringList.last;
    }
    if(location != null) {
      currentItem = HzBoxConfigItem<String>(
        type: location,
        title: location,
      );
      LocationProvider.value = location;
    }
  }

  @override
  void save({HzBoxConfigItem<String>? newItem}) {
    if(newItem != null) {
      currentItem = newItem;
    }
    // if(currentItem?.type != null) {
    //   LocationProvider.value = currentValue;
    //   HzBoxSharedPref.saveValueForKey(currentValue, 'HzBoxLocation');
    // }
    // HzBoxSharedPref.saveValueForKey(locations, 'HzBoxLocationList');

    LocationProvider.value = currentItem?.type ?? '';
    HzBoxSharedPref.saveValueForKey(currentValue, 'HzBoxLocation');
    HzBoxSharedPref.saveValueForKey(locations, 'HzBoxLocationList');
  }

  @override
  List<HzBoxConfigItem<String>> get itemList  {
    List<HzBoxConfigItem<String>> locationsItem = [];
    for (var element in locations) {
      locationsItem.add(HzBoxConfigItem<String>(
        type: element,
        title: element,
      ));
    }
    return locationsItem;
  }

  @override
  String get title => '模拟定位信息';

  @override
  String get currentValue => currentItem?.type ?? LocationProvider.value;



  // static String location = '';
  // static List<String> locationStringList = [];
  //
  // static save() async{
  //   SharedPreferences preferences =  await SharedPreferences.getInstance();
  //   preferences.setString('HzBoxLocation', location);
  // }
  //
  // static read() async{
  //   SharedPreferences preferences =  await SharedPreferences.getInstance();
  //   location = preferences.getString('HzBoxLocation') ?? '';
  // }
  //
  // static HzBoxConfigModel<String> configModel() {
  //   return HzBoxConfigModel<String>(
  //     configType: HzBoxConfigType.simulatedNav,
  //     title: '模拟定位信息',
  //     currentValue: HzBoxConfigItem<String>(
  //       type: location,
  //       title: location,
  //     ),
  //     itemList: itemList(),
  //   );
  // }
  //
  // static List<HzBoxConfigItem<String>> itemList() {
  //   List<HzBoxConfigItem<String>> locations = [];
  //   for (var element in locationStringList) {
  //     locations.add(HzBoxConfigItem<String>(
  //       type: element,
  //       title: element,
  //     ));
  //   }
  //   return locations;
  // }

}