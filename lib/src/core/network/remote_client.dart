import 'package:http/http.dart' as http;

class RemoteClient extends http.BaseClient {

  final client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {

    request.headers["x-api-key"] = "e705510a-66c4-441e-949f-8c7671445620";
    return client.send(request);
  }
}