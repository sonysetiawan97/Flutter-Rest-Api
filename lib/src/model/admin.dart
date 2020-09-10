import 'dart:convert';

class Admin {
  int id_user;
  String first_name;
  String last_name;
  int point_user;

  Admin({this.id_user, this.first_name, this.last_name, this.point_user});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id_user: int.parse(json['id_user']),
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      point_user: int.parse(json['point_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": id_user,
      "first_name": first_name,
      "last_name": last_name,
      "point_user": point_user
    };
  }

  @override
  String toString() {
    return 'admin{id_user: $id_user, first_name: $first_name, last_name: $last_name, point_user: $point_user}';
  }
}

List<Admin> adminFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Admin>.from(data.map((item) => Admin.fromJson(item)));
}

String adminToJson(Admin data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
