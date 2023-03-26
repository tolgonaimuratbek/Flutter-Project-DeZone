import 'dart:convert';
import 'package:de_zone/helpers/settings_cache.dart';
import 'package:de_zone/kurse/model_product.dart';
import 'package:de_zone/model/course_model.dart';
import 'package:flutter/cupertino.dart';

class FavoriteCourseProvider extends ChangeNotifier {
  List<Course> courses = [];

  //verwendet in CourseScreen
  //beim drücken auf Favoriten-Symbol Kurs auf Favoriten/Wunschliste einfügen
  void addCourse(Course course) {
    var index = courses.indexWhere((element) => element.id == course.id);
    if (index == -1) {
      courses.add(course);
    }
    notifyListeners();
    saveInCache();
  }

  //Daten lokal speichern, verwendet bei Favoriten einfügen/entfernen
  void saveInCache() {
    var res = json.encode(CourseModel(data: courses).toJson());
    SettingsCache.instance.setString('favoritesCourseList', res);
  }

  //verwendet in LoginScreen, NavigationsBar. Daten abrufen - diese sind auch nach der
  // Abmeldung & Anmeldung vorhanden
  void retrieveCourses() {
    SettingsCache.instance.getString('favoritesCourseList').then((value) {
      if (value != null) {
        final parsed = json.decode(value!)['data'].cast<Map<String, dynamic>>();
        var result =
            parsed.map<Course>((json) => Course.fromJson(json)).toList();
        courses = result;
        notifyListeners();
      }
    });
  }

  //verwendet in CourseCard um von Favoritenliste zu löschen
  void removeCourse(Course course) {
    var index = courses.indexWhere((element) => element.id == course.id);
    if (index != -1) {
      courses.remove(course);
    }
    notifyListeners();
    saveInCache();
  }
}
