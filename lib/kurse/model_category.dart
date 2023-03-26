//Kurskategoriemodell mit Kategorieid, Name, Bild
class Category {
  String? id;
  String? name;
  String? imageUrl;

  //Daten bekommen
  Category({this.id, this.name, this.imageUrl});
  @override
  List<Object?> get props => [name, imageUrl, id];
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '0';
    name = json['name'] ?? '';
    imageUrl = json['imageUrl'] ?? '';
  }
  //Daten senden
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
