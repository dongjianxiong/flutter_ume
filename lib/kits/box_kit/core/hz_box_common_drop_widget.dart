import 'package:flutter/material.dart';

import 'hz_box_base_provider.dart';
import 'hz_box_config_item.dart';

class HzBoxCommonDropWidget extends StatefulWidget {
  final HzBoxBaseProvider provider;
  final Function(HzBoxConfigItem item) onSelected;
  const HzBoxCommonDropWidget({
    Key? key,
    required this.provider,
    required this.onSelected,
  });

  @override
  State<StatefulWidget> createState() {
    return HzBoxCommonDropWidgetState();
  }
}

class HzBoxCommonDropWidgetState extends State<HzBoxCommonDropWidget> {
  bool _offstage = false;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.provider.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.width,
      // color: Colors.white,
      children: [
        Container(
          height: 0.5,
          color: const Color(0xffDDDDDD),
        ),
        GestureDetector(
          onTap: () {
            _offstage = !_offstage;
            if (mounted) {
              setState(() {});
            }
          },
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 50,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  widget.provider.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xff000000),
                  ),
                )),
                Icon(
                  _offstage ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: const Color(0xff555555),
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        Offstage(
          offstage: _offstage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.provider.itemList.length, (index) {
              return _buildItem(context, index);
            }),
          ),
        ),
        Container(
          height: 0.5,
          color: const Color(0xffDDDDDD),
        ),
      ],
      // child: ,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    HzBoxConfigItem item = widget.provider.itemList[index];
    return GestureDetector(
      onTap: () {
        _currentIndex = index;
        if (mounted) {
          setState(() {});
        }
        widget.onSelected.call(item);
      },
      child: Container(
        height: 40,
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
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffDDDDDD),
                    size: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            // Container(height: 0.5, color: Color(0xff555555),),
          ],
        ),
      ),
    );
  }
}
