import 'package:flutter/material.dart';

class HzBoxEditPopWidget extends StatelessWidget {
  final Function(String text) onFinish;
  HzBoxEditPopWidget({required this.onFinish});
  String _text = '';
  static Future<dynamic> show<T>(BuildContext context,
      {String? keyWord,
        required  Function(String text) onFinish,
        Color? bgColor,
        bool? useSafeArea, }) async {
    return await showDialog<T>(
      context: context,
      useSafeArea: useSafeArea ?? false,
      builder: (ctx) {
        return HzBoxEditPopWidget(onFinish: onFinish,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 160,
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Expanded(child: TextField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xff777777)
                ),
                hintText: '请输入经纬度(经度,维度),如(117.23,34.45),输入不带括号',
              ),
              onChanged: (String text){
                _text = text;
                onFinish.call(text);
              },
            )),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop(_text);
              },
              child: Container(
                width: 200,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text('完成'),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

}