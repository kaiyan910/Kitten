import 'package:kitten/src/core/network/remote_client.dart';
import 'dart:convert';

import 'package:kitten/src/core/network/model/cat.dart';

final _root = "https://api.thecatapi.com";

class RemoteProvider {
  RemoteClient client = RemoteClient();

  Future<List<Cat>> search(int limit, int page, String mimeType) async {

    final response = await client.get("$_root/v1/images/search?limit=$limit&page=$page&mime_types=$mimeType");
    final body = json.decode(response.body);

    return (body as List).map((cat) => Cat.from(cat)).toList();
  }
}
