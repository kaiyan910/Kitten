import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kitten/src/core/constant.dart';

class ApiClient extends http.BaseClient {

  final Client _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {

    request.headers["x-api-key"] = Constant.API_KEY;
    return _client.send(request);
  }
}