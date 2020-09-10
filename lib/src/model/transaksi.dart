import 'dart:convert';

class Transaksi {
  int id_transaksi;
  int id_user;
  int total_transaksi;

  Transaksi({this.id_transaksi, this.id_user, this.total_transaksi});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id_transaksi: int.parse(json['id_transaksi']),
      id_user: int.parse(json['id_user']),
      total_transaksi: int.parse(json['total_transaksi']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_transaksi": id_transaksi,
      "id_user": id_user,
      "total_transaksi": total_transaksi,
    };
  }

  @override
  String toString() {
    return 'admin{id_transaksi: $id_transaksi, id_user: $id_user, total_transaksi: $total_transaksi}';
  }
}

List<Transaksi> adminFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Transaksi>.from(data.map((item) => Transaksi.fromJson(item)));
}

String adminToJson(Transaksi data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
