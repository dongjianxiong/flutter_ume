import 'package:shared_preferences/shared_preferences.dart';

class HzBoxSharedPref {
  static SharedPreferences? preferences;
  static init() async{
    preferences =  await SharedPreferences.getInstance();
  }

  static void saveValueForKey(dynamic value, String key){
    print('HzBoxKit:=======save value:$value for key:$key==========');

    if(value is bool) {
      preferences?.setBool(key, value);
    } else if(value is String) {
      preferences?.setString(key, value);
    } else if(value is double) {
      preferences?.setDouble(key, value);
    } else if(value is int) {
      preferences?.setInt(key, value);
    } else if(value is List<String>) {
      preferences?.setStringList(key, value);
    } else {
      preferences?.setString(key, value.toString());
    }
  }

  static dynamic getValueForKey(String key){
    dynamic value = preferences?.get(key);
    print('HzBoxKit:=======get value:$value for key:$key==========');
    return value;
  }

}