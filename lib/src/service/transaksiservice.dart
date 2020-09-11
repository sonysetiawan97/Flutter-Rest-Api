import 'package:flutterrestapi/src/model/transaksi.dart';
import 'package:http/http.dart' show Client;

class TransaksiApiService {
  final String baseUrl = "http://10.0.2.2/rest_ci/index.php";
  Client client = Client();

  Future<List<Transaksi>> getTransaksi() async {
    final response = await client.get("$baseUrl/RestApi/ApiTransaksi");
    if (response.statusCode == 200) {
      return adminFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> postTransaksi(Transaksi data) async {
    final response = await client.post(
      "$baseUrl/RestApi/ApiTransaksi",
      headers: {"content-type": "application/json"},
      body: adminToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool> putTransaksi(Transaksi data) async {
    final response = await client.put(
      "$baseUrl/RestApi/ApiTransaksi/${data.id_transaksi}",
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

  Future<bool> deleteTransaksi(int id) async {
    final response = await client.delete(
      "$baseUrl/RestApi/ApiTransaksi/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
