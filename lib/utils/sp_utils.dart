import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences本地存储工具类（单例模式）
/// 提供类型安全的键值存取方法
class SpUtils {
  // 单例实例
  static final SpUtils _instance = SpUtils._internal();
  late SharedPreferences _prefs;

  // 私有构造函数
  SpUtils._internal();

  // 工厂构造函数
  factory SpUtils() => _instance;

  /// 初始化方法（必须调用）
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ------------------ 存储方法 ------------------
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);
  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  // ------------------ 读取方法 ------------------
  int? getInt(String key) => _prefs.getInt(key);
  bool? getBool(String key) => _prefs.getBool(key);
  String? getString(String key) => _prefs.getString(key);
  double? getDouble(String key) => _prefs.getDouble(key);
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  /// 通用删除方法
  Future<bool> remove(String key) => _prefs.remove(key);

  /// 清空所有存储
  Future<bool> clear() => _prefs.clear();

  /// 检查key是否存在
  bool containsKey(String key) => _prefs.containsKey(key);
}
