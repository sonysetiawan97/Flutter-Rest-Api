import 'dart:convert';

class Hadiah {
  int id_hadiah;
  String nama_hadiah;
  int point_hadiah;

  Hadiah({this.id_hadiah, this.nama_hadiah, this.point_hadiah});

  factory Hadiah.fromJson(Map<String, dynamic> json) {
    return Hadiah(
      id_hadiah: int.parse(json['id_hadiah']),
      nama_hadiah: json['nama_hadiah'] as String,
      point_hadiah: int.parse(json['point_hadiah']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_hadiah": id_hadiah,
      "nama_hadiah": nama_hadiah,
      "point_hadiah": point_hadiah,
    };
  }

  @override
  String toString() {
    return 'admin{id_hadiah: $id_hadiah, id_hadiah: $nama_hadiah, point_hadiah: $point_hadiah}';
  }
}

List<Hadiah> adminFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Hadiah>.from(data.map((item) => Hadiah.fromJson(item)));
}

String adminToJson(Hadiah data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
