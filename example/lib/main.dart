import 'package:dio/dio.dart';
import 'package:example/custom_router_pluggable.dart';
import 'package:example/detail_page.dart';
import 'package:example/home_page.dart';
import 'package:example/ume_switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:provider/provider.dart';

final Dio dio = Dio()..options = BaseOptions(connectTimeout: Duration(seconds: 10000));

final navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(const UMEApp());

class UMEApp extends StatefulWidget {
  const UMEApp({Key? key}) : super(key: key);

  @override
  State<UMEApp> createState() => _UMEAppState();
}

class _UMEAppState extends State<UMEApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomRouterPluggable().navKey = navigatorKey;
      _setup();
    });
  }

  void _setup() async {
    if (!kReleaseMode) {
      await HzBoxSharedPref.init();
      dio.interceptors.add(DioInspector.dioInterceptor);

      // PluginManager.instance.registerAll([
      //   DioInspector(),
      //   if(kDebugMode) WidgetInfoInspector(),
      //   if(kDebugMode) WidgetDetailInspector(),
      //   MemoryInfoPage(),
      // ]);

      PluginManager.instance
        ..register(LocationPlugin(onFinish: (isInit) {
          print(LocationProvider.value);
          print(SimulatedNaviProvider.value);
        }))
        ..register(ServiceEnvPlugin(onFinish: (isInit) {
          print(ServiceEnvProvider.value);
        }))
        ..register(LogLevelPlugin(onFinish: (isInit) {
          print(LogLevelProvider.value);
        }))
        ..register(DioInspector())
        ..register(CustomPlugin(
            eventNames: ['进入首页', '进入接单页面'],
            onFinish: (String eventName) {
              print('Event name $eventName');
            }))
        ..register(TouchIndicator())
        ..register(Performance())
        ..register(Console())
        ..register(WidgetInfoInspector())
        ..register(WidgetDetailInspector())
        ..register(ColorSucker())
        ..register(ColorPicker())
        ..register(MemoryInfoPage())
        ..register(CpuInfoPage())
        ..register(DeviceInfoPanel())
        ..register(AlignRuler())
        ..register(CustomRouterPluggable())
        ..register(ShowCode())
        ..register(ChannelPlugin())
        ..register(HttpsProxyPlugin(
          (event) => {
            debugPrint("event-----"),
            debugPrint(event),
          },
        ));
    }
  }

  Widget _buildApp(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'UME Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(title: 'UME Demo Home Page'),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'detail':
            return MaterialPageRoute(builder: (_) => const DetailPage());
          default:
            return null;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = _buildApp(context);
    if (kDebugMode) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UMESwitch()),
        ],
        builder: (BuildContext context, _) => UMEWidget(
          enable: context.watch<UMESwitch>().enable,
          child: body,
        ),
      );
    }
    return body;
  }
}
