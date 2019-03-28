import 'package:kitten/src/core/model/cat.dart';
import 'package:kitten/src/core/network/api_provider.dart';

class RemoteRepository {

  final ApiProvider _apiProvider = apiProvider;

  Future<List<Cat>> search(int limit, int page, String mimeType) async => _apiProvider.search(limit, page, mimeType);
}

final remoteRepository = RemoteRepository();