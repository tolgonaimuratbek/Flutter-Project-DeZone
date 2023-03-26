import 'package:de_zone/kurse/model_product.dart';
import 'package:uuid/uuid.dart';

//Modell für Kurse mit ID, Namen, KatogorieId, Bild, Preis, Gruppenkurs oder Prüfungsvorbereitungskurse
class Course {
  String? id;
  String? name;
  String? categoryId;
  String? imageUrl;
  double? price;
  bool? isGeneralCourse;
  bool? isExamPrepCourse;

  Course(
      {this.name,
      this.id,
      this.categoryId,
      this.imageUrl,
      this.price,
      this.isGeneralCourse,
      this.isExamPrepCourse});
  @override
  List<Object?> get props => [
        name,
        categoryId,
        id,
        imageUrl,
        price,
        isGeneralCourse,
        isExamPrepCourse,
      ];

  //Daten bekommen
  Course.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'] ?? "0";

    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    isGeneralCourse = json['isGeneralCourse'];
    isExamPrepCourse = json['isExamPrepCourse'];
  }

  //Daten senden
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Course = new Map<String, dynamic>();
    Course['name'] = this.name;
    Course['id'] = this.id;
    Course['categoryId'] = this.categoryId;
    Course['imageUrl'] = this.imageUrl;
    Course['price'] = this.price;
    Course['isGeneralCourse'] = this.isGeneralCourse;
    Course['isExamPrepCourse'] = this.isExamPrepCourse;
    return Course;
  }
}
