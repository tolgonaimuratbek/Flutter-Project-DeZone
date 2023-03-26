import 'package:de_zone/kurse/model_product.dart';

//verwendet in FavoriteCourseProvider
class CourseModel {
  List<Course>? data;

  CourseModel({this.data});

  //daten werden zuerst nach json umgewandelt und dann
  //Daten bekommen
  CourseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Course>[];
      json['data'].forEach((v) {
        data!.add(Course.fromJson(v));
      });
    }
  }

  //Daten senden
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
