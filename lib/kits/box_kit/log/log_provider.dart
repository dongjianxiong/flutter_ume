import '../box_kit.dart';

/// 日志级别
enum LogLevelType {
  /// 所有日志
  all,

  /// 追踪日志
  trace,

  /// debug日志
  debug,

  /// 一般级别
  info,

  /// 警告级别
  warming,

  /// 错误级别
  error,

  /// 严重
  fatal,
}

class LogLevelProvider with HzBoxBaseProvider<LogLevelType> {
  static LogLevelType value = LogLevelType.all;

  LogLevelProvider() {
    String name = HzBoxSharedPref.getValueForKey('HzBoxLogLevelType') ?? LogLevelType.all.name;
    for (var element in LogLevelType.values) {
      if (element.name == name) {
        currentItem = HzBoxConfigItem<LogLevelType>(
          type: element,
          title: _titleForType(element),
        );
        LogLevelProvider.value = element;
      }
    }
  }

  @override
  void save({HzBoxConfigItem<LogLevelType>? newItem}) {
    if (newItem != null) {
      currentItem = newItem;
    }
    if (currentItem?.type != null) {
      LogLevelProvider.value = currentValue;
      HzBoxSharedPref.saveValueForKey(currentValue.name, 'HzBoxLogLevelType');
    }
  }

  @override
  List<HzBoxConfigItem<LogLevelType>> get itemList {
    return [
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.all,
        title: _titleForType(LogLevelType.all),
        detail: '打印所有日志。下面可以根据需要选择日志级别。级别越低展示的日志越多，可以根据需要进行过滤\n',
      ),
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.trace,
        title: _titleForType(LogLevelType.trace),
        detail:
            'Trace 日志记录非常详细的信息，主要用于深度调试和诊断问题。这些信息通常在生产环境中不启用，因为它们可能会产生大量日志数据。\n\n典型用途：\n记录函数的输入和输出参数。\n记录循环中的每一步操作。\n记录详细的调试信息。\n',
      ),
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.debug,
        title: _titleForType(LogLevelType.debug),
        detail:
            'Debug 日志用于记录调试信息，提供应用程序正常运行期间的有用信息。这些信息比 verbose 少，但仍然非常详细。\n\n典型用途：\n记录应用程序的主要流程步骤。\n记录重要变量的值和状态变化。\n记录网络请求的详细信息。\n',
      ),
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.info,
        title: _titleForType(LogLevelType.info),
        detail:
            'Info 日志用于记录普通操作的信息，帮助了解应用程序的正常运行情况。这些信息应足够简洁，但能提供有用的概述。\n\n典型用途：\n记录应用程序的启动和停止。\n记录用户登录和注销。\n记录重要业务操作的成功完成。\n',
      ),
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.warming,
        title: _titleForType(LogLevelType.warming),
        detail:
            'Warning 日志用于记录可能导致问题的潜在情况。这些情况不一定会导致应用程序崩溃，但应引起注意。\n\n典型用途：\n记录可能的性能问题。\n记录已处理但不理想的异常。\n记录不推荐的操作或使用模式。\n',
      ),
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.error,
        title: _titleForType(LogLevelType.error),
        detail:
            'Error 日志用于记录导致应用程序功能失败的严重问题。这些问题通常需要立即关注和解决。\n\n典型用途：\n记录未处理的异常。\n记录导致功能中断的错误。\n记录数据损坏或丢失。\n',
      ),
      HzBoxConfigItem<LogLevelType>(
        type: LogLevelType.fatal,
        title: _titleForType(LogLevelType.fatal),
        detail:
            'Fatal 日志用于记录不应该发生的严重错误或故障。这些日志通常表示系统处于不可恢复的状态，需要立即修复。\n\n典型用途：\n记录严重的系统崩溃。\n记录不可恢复的错误。\n记录关键功能的失败。\n',
      )
    ];
  }

  @override
  String get title => '日志开关';

  @override
  LogLevelType get currentValue => currentItem?.type ?? LogLevelProvider.value;

  String _titleForType(LogLevelType type) {
    String title = '';
    switch (type) {
      case LogLevelType.all:
        title = 'All';
        break;
      case LogLevelType.trace:
        title = 'Trace';
        break;
      case LogLevelType.debug:
        title = 'Debug';
        break;
      case LogLevelType.info:
        title = 'Info';
        break;
      case LogLevelType.warming:
        title = 'Warming';
        break;
      case LogLevelType.error:
        title = 'Error';
        break;
      case LogLevelType.fatal:
        title = 'Fatal';
        break;
    }
    return title;
  }
}
