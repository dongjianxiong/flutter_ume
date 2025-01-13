import 'package:flutter/material.dart';

import '../core/hz_box_common_drop_widget.dart';
import '../core/hz_box_config_item.dart';
import '../location/location_list_widget.dart';
import '../location/location_provider.dart';
import 'hz_box_base_provider.dart';

class HzBoxConfigWidget extends StatelessWidget {
  final List<HzBoxBaseProvider> providers;
  final Function()? onFinish;
  final String? title;
  final Function(HzBoxBaseProvider provider, HzBoxConfigItem item)? onSelected;
  HzBoxConfigWidget({
    required this.providers,
    required this.onSelected,
    this.title,
    this.onFinish,
  });
  static Future<dynamic> show<T>(
    BuildContext context, {
    String? keyWord,
    required List<HzBoxBaseProvider> providers,
    required Function(HzBoxBaseProvider provider, HzBoxConfigItem item) onSelected,
    Function()? onFinish,
    bool showFinishButton = true,
    Color? bgColor,
    bool? useSafeArea,
  }) async {
    return await showDialog<T>(
      context: context,
      useSafeArea: useSafeArea ?? false,
      builder: (ctx) {
        return HzBoxConfigWidget(
          providers: providers,
          onSelected: onSelected,
          onFinish: onFinish,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 74,
          ),
          Text(
            title ?? '开发配置',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff000000),
            ),
          ),
          Expanded(child: _buildContent()),
          if (onFinish != null)
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pop();
                onFinish?.call();
              },
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: Container(
                      width: 224,
                      height: 48,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text(
                        '完成',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          const SizedBox(
            height: 44,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: _buildItem,
      itemCount: providers.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    HzBoxBaseProvider provider = providers[index];
    if (provider is LocationProvider) {
      return LocationListWidget(
        currentIndex: provider.currentIndex ?? -1,
        locationProvider: provider,
        onSelected: (HzBoxConfigItem item) {
          onSelected?.call(provider, item);
          // Navigator.of(context).pop();
        },
      );
    }
    return HzBoxCommonDropWidget(
      provider: provider,
      onSelected: (HzBoxConfigItem item) {
        onSelected?.call(provider, item);
        // Navigator.of(context).pop();
      },
    );
  }
}
