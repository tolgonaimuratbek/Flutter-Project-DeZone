//Datenmodell für Chat mit Nachricht, AbsendeId, EmpfängerId, AbsenderName, Filename, Nachrichtart, Uhrzeit
class MessageModel {
  String? message;
  String? from;
  String? to;
  String? senderName;
  String? filename;
  String? type;
  String? timestamp;

  MessageModel(
      {this.message,
      this.from,
      this.to,
      this.senderName,
      this.filename,
      this.type,
      this.timestamp});

  //Daten werden zuerst nach json umgewandelt
  //Daten holen
  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    from = json['from'];
    to = json['to'];
    senderName = json['senderName'];
    filename = json['filename'];
    type = json['type'];
    timestamp = json['timestamp'] ?? '';
  }

  //Daten werden zuerst nach json umgewandelt
  //Daten senden
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['from'] = this.from;
    data['to'] = this.to;
    data['senderName'] = this.senderName;
    data['filename'] = this.filename;
    data['type'] = this.type;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
