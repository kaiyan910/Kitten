import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/core/network/api_client.dart';
import 'dart:convert';

final _root = "https://api.thecatapi.com";

class ApiProvider {

  final ApiClient _client;

  ApiProvider(this._client);

  Future<List<Cat>> search(int limit, int page, String mimeType) async {
    final response = await _client.get(
        "$_root/v1/images/search?limit=$limit&page=$page&mime_types=$mimeType?order=RANDOM");
    final body = json.decode(response.body);

    return (body as List).map((cat) => Cat.fromJSON(cat)).toList();
  }
}