import 'package:flutter/material.dart';

import '../box_kit.dart';

class LocationListWidget extends StatefulWidget {
  final int currentIndex;
  final LocationProvider locationProvider;
  final Function(HzBoxConfigItem item) onSelected;
  const LocationListWidget({
    Key? key,
    required this.locationProvider,
    required this.onSelected,
    required this.currentIndex,
  });

  @override
  State<StatefulWidget> createState() {
    return LocationListWidgetState();
  }
}

class LocationListWidgetState extends State<LocationListWidget> {
  bool _offstage = false;
  int _currentIndex = 0;
  TextEditingController _editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<HzBoxConfigItem<String>> itemList = widget.locationProvider.itemList;
    return Column(
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
                  widget.locationProvider.title,
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
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: List.generate(itemList.length, (index) {
              // if(itemList.length == index) {
              //   return _buildAddButton();
              // }
              return _buildLocationItem(index);
            }),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            SizedBox(
              height: 60,
              width: 280,
              child: TextField(
                controller: _editingController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 10, color: Color(0xff777777)),
                  hintText: '请输入经纬度(经度,维度),如(117.23,34.45),输入不带括号',
                ),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            _buildAddButton(),
            SizedBox(
              width: 2,
            ),
            _buildCleanButton(),
            Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 0.5,
          color: const Color(0xffDDDDDD),
        ),
      ],
      // child: ,
    );
  }

  Widget _buildLocationItem(int index) {
    final isSelected = _currentIndex == index;
    HzBoxConfigItem<String> item = widget.locationProvider.itemList[index];
    return GestureDetector(
      onTap: () {
        _currentIndex = index;
        widget.onSelected(item);
        if (mounted) {
          setState(() {});
        }
      },
      child: Container(
        // color: Colors.green,
        width: 160,
        height: 40,
        // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : const Color(0xffe6e6e6),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              '${item.title}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black,
              ),
            )),
            GestureDetector(
              onTap: () {
                widget.locationProvider.locations.removeAt(index);
                if (index == _currentIndex) {
                  widget.locationProvider.currentItem = null;
                }
                widget.locationProvider.save();
                if (mounted) {
                  setState(() {});
                }
              },
              child: Icon(
                Icons.close,
                size: 16,
                color: isSelected ? Colors.white : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        // 115.7°-117.4°,北纬39.4°-41.6°
        String value = _editingController.text;
        if (value.isEmpty) {
          return;
        }
        List<String> numbers = value.split(',');
        if (numbers.length != 2) {
          print('HzBoxKit:==========Invalid location text:$value=========');
          return;
        }

        print('HzBoxKit:========location:$value=========');
        if (!widget.locationProvider.locations.contains(value)) {
          _offstage = false;
          widget.locationProvider.locations.add(value);
          _currentIndex = widget.locationProvider.itemList.length - 1;
          HzBoxConfigItem<String> item = HzBoxConfigItem<String>(
            type: value,
            title: value,
          );
          widget.onSelected(item);
          if (mounted) {
            setState(() {});
          }
        }
      },
      child: Container(
        // color: Colors.green,
        width: 34,
        height: 34,
        // padding: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: const Icon(Icons.add, size: 22, color: Colors.white),
      ),
    );
  }

  Widget _buildCleanButton() {
    return GestureDetector(
      onTap: () {
        _editingController.text = '';
        if (mounted) {
          setState(() {});
        }
      },
      child: Container(
        // color: Colors.green,
        width: 34,
        height: 34,
        // padding: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
        ),
        child: const Icon(Icons.cleaning_services, size: 22, color: Colors.grey),
      ),
    );
  }
}
