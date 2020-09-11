import 'dart:convert';

class Transaksi {
  int id_transaksi;
  int id_user;
  int total_transaksi;
  String first_name;
  String last_name;

  Transaksi(
      {this.id_transaksi,
      this.id_user,
      this.total_transaksi,
      this.first_name,
      this.last_name});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id_user: int.parse(json['id_user']),
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      id_transaksi: int.parse(json['id_transaksi']),
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
    return 'admin{id_transaksi: $id_transaksi, id_user: $id_user, total_transaksi: $total_transaksi, first_name: $first_name, last_name: $last_name}';
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
