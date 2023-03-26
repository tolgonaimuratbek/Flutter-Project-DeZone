import 'package:de_zone/kurse/model_category.dart';
import 'package:de_zone/kurse/model_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Daten holen Kurs Kategorie
final categoryRef =
    FirebaseFirestore.instance.collection('categories').withConverter<Category>(
          fromFirestore: (snapshots, _) => Category.fromJson(snapshots.data()!),
          toFirestore: (category, _) => category.toJson(),
        );
//Daten holen Kurs Produkte
final coursesRef =
    FirebaseFirestore.instance.collection('products').withConverter<Course>(
          fromFirestore: (snapshots, _) => Course.fromJson(snapshots.data()!),
          toFirestore: (product, _) => product.toJson(),
        );

//Liste erstellt
class CourseAndCategoryProvider with ChangeNotifier {
  final List<Category> _categories = [];
  List<Course> _courses = [];
//speichern auf _currentCategory
  Category? _currentCategory = Category();
  set currentCategory(Category cat) {
    _currentCategory = cat;
  }

  Category get currentCategory => _currentCategory!;
  //setter
  set categories(List<Category> cat) {
    categories = cat;
  }

  List<Category> get categories => _categories;

  set courses(List<Course> courses) {
    _courses = courses;
  }

  List<Course> get courses => _courses ?? [];
  //verwendet in CoursesScreen, alle Kurs Daten von der Tabelle holen
  Future<dynamic> fetchCourses() async {
    try {
      if (courses.isNotEmpty) {
        _courses = [];
      }
      var categoriesSnapshots = await categoryRef.get();
      var coursesSnapshots = await coursesRef.get();

      for (var sn in categoriesSnapshots.docs) {
        Category cat = sn.data();
        categories?.add(cat);
      }
      for (var sn in coursesSnapshots.docs) {
        Course cat = sn.data();
        courses?.add(cat);
      }
      notifyListeners();
      return 'done';
    } catch (e) {
      return e;
    }
  }
}
