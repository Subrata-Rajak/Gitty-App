import 'package:http/http.dart' as http;

class HttpService {
  static HttpService instance = HttpService();
  final httpClient = http.Client();
}
