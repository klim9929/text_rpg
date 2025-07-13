import 'package:shared_preferences/shared_preferences.dart';

class OptimizationSettings {
  static const String key = 'optimization_level';
  static const List<String> levels = ['high', 'medium', 'low'];

  static Future<String> getLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'medium';
  }

  static Future<void> setLevel(String level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, level);
  }
}
