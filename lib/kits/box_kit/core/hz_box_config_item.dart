// ProjectConfigType.serviceEnv :{
// 'configType': ProjectConfigType.serviceEnv,
// 'title': '服务环境',
// 'current': envType,
// 'itemList': ServiceEnvProvider.itemList,
// }

class HzBoxConfigItem<T> {
  T? type;
  String? title;
  String? detail;

  HzBoxConfigItem({this.type, this.title, this.detail});
  HzBoxConfigItem.from(dynamic json) {
    if (json != null && json is Map) {
      type = json['type'];
      title = json['title'];
      detail = json['detail'];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['type'] = type;
    map['title'] = title;
    map['detail'] = detail;
    return map;
  }
}
