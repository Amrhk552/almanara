import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseManager {
  static late SharedPreferences _prefs;

  // تحميل SharedPreferences عند بدء التطبيق
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // حفظ قيمة في SharedPreferences
  static void save(String key, dynamic val) {
    if (val is List<dynamic> || val is Map) {
      _prefs.setString(key, json.encode(val));
    } else if (val is List<String>) {
      _prefs.setStringList(key, val);
    } else if (val is String) {
      _prefs.setString(key, val);
    } else if (val is bool) {
      _prefs.setBool(key, val);
    } else if (val is double) {
      _prefs.setDouble(key, val);
    } else if (val is int) {
      _prefs.setInt(key, val);
    }
  }

  // تحميل قيمة من SharedPreferences
  static dynamic load(String key) {
    var value = _prefs.get(key);
    if (key == 'language' && value == null) {
      save('language', 'ar');
      return 'ar';
    }
    return value;
  }

  // حذف مفتاح من SharedPreferences
  static void unset(String key) {
    _prefs.remove(key);
  }

  // التحقق من وجود مفتاح في SharedPreferences
  static bool exist(String key) {
    return _prefs.containsKey(key);
  }

  // حذف جميع البيانات باستثناء الثيم واللغة
  static Future<void> clear() async {
    String? themeMode = load('isDarkTheme');
    String? languageMode = load('language');
    await _prefs.clear();
    save('isDarkTheme', themeMode);
    save('language', languageMode);
  }

  // تحميل قيمة من SharedPreferences كـ bool
  static bool loadBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  // التحقق إذا كان المستخدم هو المسؤول
  static bool isAdmin() {
    var role = load('role');
    print('Role: $role'); // Debugging
    return load('role') == 'admin';
  }

  // التحقق إذا كانت اللغة عربية
  static bool isArabic() {
    return load('language') == 'ar';
  }

  static String getLanguageCode() {
    return load('language');
  }

  static bool isRightToLeft() {
    return load('language') == 'ar' || load('language') == 'ur';
  }

  // التحقق إذا كان الثيم داكن
  static bool isDarkTheme() {
    return load('isDarkTheme') == 'true';
  }
}
