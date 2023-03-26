import 'package:shared_preferences/shared_preferences.dart';

//für Daten die lokal gespeichert werden - kann verwenden

class SettingsCache {
  SettingsCache._privateConstructor();

  //Instanz
  static final SettingsCache instance = SettingsCache._privateConstructor();

  //String Setter um zu speichern/setzen
  //verwendet in Seiten wie Login, SignUp, FavoriteCourseProvider
  //Verwendung einer Chache auf der Dart-Seite, die wird mit set-Methode aktualisiert
  setString(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  //String Getter um zu holen/lesen
  //Verwendet in NavigationBar, FavoriteCourseProvider
  Future<String?> getString(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? null;
  }

  //Account (Passwort ändern), SeitenBar (Abmelden)
  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }
}

/*
  Future<int?> getIntValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? null;
  }

  setListValue(String key, List<String> list) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, list);
  }

  Future<List<String>?> getStringList(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key) ?? null;
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

 Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }
*/
