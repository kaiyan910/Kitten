import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:kitten/src/core/network/model/Image.dart';

final _root = "https://api.thecatapi.com";

class ApiProvider {

  Client client = Client();
}