
import 'package:flutter/material.dart';

class OverFloatWidget extends StatefulWidget {

  static OverlayEntry? _overlayEntry;
  static Offset _offset = const Offset(10, 50);
  static show(BuildContext context, {required Function(BuildContext childContext) onTap}) async {
    if(_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry?.remove();
    }
    _overlayEntry = OverlayEntry(
      builder: (childContext) {
        return Positioned(
          top: _offset.dy,
          left: _offset.dx,
          child: OverFloatWidget(
            limitPadding: const EdgeInsets.only(left: 0, right: 0, top: 44, bottom: 34),
            originPosition: const Offset(10, 50),
            onTap: (){
              onTap.call(childContext);
            },
            dragEnd: (value) {
              _offset = value;
            },
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  final EdgeInsets? limitPadding;
  final Offset? originPosition;
  final Function(Offset currentOffset) dragEnd;
  final Function() onTap;
  const OverFloatWidget({
    this.limitPadding,
    this.originPosition,
    required this.dragEnd,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return OverFloatWidgetState();
  }
}

class OverFloatWidgetState extends State<OverFloatWidget> {

  EdgeInsets _limitPadding = const EdgeInsets.all(0);
  Offset _originPosition = const Offset(10, 44);
  late Offset _currentPosition = _originPosition;
  final GlobalKey _overlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if(widget.originPosition != null) {
      _originPosition = widget.originPosition!;
    }
    if(widget.limitPadding != null) {
      _limitPadding = widget.limitPadding!;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: _overlayKey,
      width: 60,
      height: 60,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Draggable(
      feedback: _buildChild(),
      onDragUpdate: (DragUpdateDetails details){
        _currentPosition = details.localPosition;
      },
      onDragEnd: (res){
        // print(res);
        double y = _currentPosition.dy;
        double x = _currentPosition.dx;
        print('---------$x');
        if (y > (screenHeight - 60 - _limitPadding.bottom)) {
          y = screenHeight - 60 - _limitPadding.bottom;
        }
        if (y < _limitPadding.top){
          y = _limitPadding.top;
        }
        if (x < _limitPadding.left) {

        } else if (x > screenWidth - 60 - _limitPadding.right) {
          x = screenWidth - 60 - _limitPadding.right;
        } else {
        }
        _currentPosition = Offset(x, y);
        widget.dragEnd.call(_currentPosition);
      },
      childWhenDragging: Container(),
      child: _buildChild(), // Widget to show in the original position while dragging
    );
  }

  Widget _buildChild() {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Container(
          width: 60,
          height: 60,
          color: Colors.green.withOpacity(0.3),
          alignment: Alignment.center,
          child:  const Text(
            '设置',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
