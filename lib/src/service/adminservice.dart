import 'package:flutterrestapi/src/model/admin.dart';
import 'package:http/http.dart' show Client, Response, delete;

class AdminApiService {
  final String baseUrl = "http://192.168.0.110/rest_ci/index.php";
  Client client = Client();

  Future<List<Admin>> getUsers() async {
    final response = await client.get("$baseUrl/RestApi/ApiUser");
    if (response.statusCode == 200) {
      return adminFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> postUsers(Admin data) async {
    final response = await client.post(
      "$baseUrl/RestApi/ApiUser",
      headers: {"content-type": "application/json"},
      body: adminToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool> putUsers(Admin data) async {
    final response = await client.put(
      "$baseUrl/RestApi/ApiUser/${data.id_user}",
      headers: {"content-type": "application/json"},
      body: adminToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  // Future<void> deleteUsers(int id) async {
  //   Response res = await delete("$baseUrl/user/$id");

  //   if (res.statusCode == 200) {
  //     print("$baseUrl/user/$id");
  //     print("DELETED $id");
  //   } else {
  //     throw "Can't delete post.";
  //   }
  // }

  // Future<Response> deleteUsers(int id) async {
  //   final response = await client.delete(
  //     "$baseUrl/user/$id",
  //     headers: {"content-type": "application/json"},
  //   );
  //   print("$response");
  //   return response;
  // }

  Future<bool> deleteUsers(int id) async {
    final response = await client.delete(
      "$baseUrl/RestApi/ApiUser/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
