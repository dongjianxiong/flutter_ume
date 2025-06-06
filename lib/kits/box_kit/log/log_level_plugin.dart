import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ume/flutter_ume.dart';

const logIconData =
    r'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';

// const envIconData = r'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';
final logIconBytes = base64Decode(logIconData);

class LogLevelPlugin implements Pluggable {
  late HzBoxBaseProvider _provider;
  final Function(bool) onFinish;
  LogLevelPlugin({required this.onFinish}) {
    _provider = LogLevelProvider();
    onFinish.call(true);
  }

  @override
  Widget? buildWidget(BuildContext? context) {
    return LogLevelWidget(
        provider: _provider,
        onSelected: (item) {
          _provider.save(newItem: item);
          onFinish.call(false);
        });
    // return HzBoxConfigWidget(
    //   providers: _providers,
    //   title: displayName,
    //   onSelected: (HzBoxBaseProvider<dynamic> provider, HzBoxConfigItem<dynamic> item) {
    //     provider.save(newItem: item);
    //     onFinish.call(false);
    //   },
    // );
  }

  @override
  String get displayName => '日志开关';

  @override
  ImageProvider<Object> get iconImageProvider => MemoryImage(logIconBytes);

  @override
  String get name => 'LogLevelPlugin'; //

  @override
  void onTrigger() {}
}

class LogLevelWidget extends StatefulWidget {
  final HzBoxBaseProvider? provider;
  final Function(HzBoxConfigItem item) onSelected;
  LogLevelWidget({
    Key? key,
    required this.onSelected,
    this.provider,
  });

  @override
  State<StatefulWidget> createState() {
    return LogLevelWidgetState();
  }
}

class LogLevelWidgetState extends State<LogLevelWidget> {
  int _currentIndex = 0;
  int _showDetailIndex = -1;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.provider?.currentIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 0.5,
            color: const Color(0xffDDDDDD),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _buildItem,
              itemCount: widget.provider?.itemList.length ?? 0,
            ),
          ),
          Container(
            height: 0.5,
            color: const Color(0xffDDDDDD),
          ),
        ],
        // child: ,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    HzBoxConfigItem item = widget.provider!.itemList[index];
    return GestureDetector(
      onTap: () {
        _currentIndex = index;
        if (mounted) {
          setState(() {});
        }
        widget.onSelected.call(item);
      },
      child: Container(
        // height: 40,
        // color: Color(0xffD5D5D5),
        color: index == _currentIndex ? const Color(0xffDCDCDC) : const Color(0xffFFFFFF),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 0.5,
              color: const Color(0xffDDDDDD),
            ),
            SizedBox(
              height: 39,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.title ?? '',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: index == _currentIndex
                              ? const Color(0xff333333)
                              : const Color(0xff777777),
                        ),
                      ),
                    ),
                  ),
                  // const Icon(
                  //   Icons.arrow_forward_ios,
                  //   color: Color(0xffDDDDDD),
                  //   size: 16,
                  // ),
                  GestureDetector(
                    onTap: () {
                      if (_showDetailIndex == index) {
                        _showDetailIndex = -1;
                      } else {
                        _showDetailIndex = index;
                      }
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Icon(
                      _showDetailIndex != index ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: const Color(0xff555555),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: _showDetailIndex != index,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: Text(item.detail ?? '详细信息'),
              ),
            ),
            Container(
              height: 0.5,
              color: Color(0xff555555),
            ),
          ],
        ),
      ),
    );
  }
}
