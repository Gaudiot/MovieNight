import 'package:shared_preferences/shared_preferences.dart';

const String storagePrefix = "@MovieNight/";

class LocalStorage{
  //BOOL--------------------------------------------------------------------------------------------------------------
  static Future<bool> setBool(String key, bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setBool("$storagePrefix$key", value);
  }

  static Future<bool> getBool(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getBool("$storagePrefix$key") ?? false;
  }

  //DOUBLE--------------------------------------------------------------------------------------------------------------
  static Future<bool> setDouble(String key, double value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setDouble("$storagePrefix$key", value);
  }

  static Future<double> getDouble(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getDouble("$storagePrefix$key") ?? 0;
  }

  //INT--------------------------------------------------------------------------------------------------------------
  static Future<bool> setInt(String key, int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setInt("$storagePrefix$key", value);
  }

  static Future<int> getInt(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getInt("$storagePrefix$key") ?? 0;
  }

  //STRING--------------------------------------------------------------------------------------------------------------
  static Future<bool> setString(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setString("$storagePrefix$key", value);
  }
  
  static Future<String> getString(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getString("$storagePrefix$key") ?? "";
  }

  //STRING LIST--------------------------------------------------------------------------------------------------------------
  static Future<bool> setStringList(String key, List<String> value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setStringList("$storagePrefix$key", value);
  }
  
  static Future<List<String>> getStringList(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getStringList("$storagePrefix$key") ?? [];
  }

  static Future<bool> keyExists(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Set<String> keys = prefs.getKeys();
    return keys.contains("$storagePrefix$key");
  }
}