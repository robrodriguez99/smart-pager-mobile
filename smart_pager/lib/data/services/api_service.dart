import 'package:http/http.dart' as http;

class ApiService {
  final http.Client httpClient;
  String baseUrl = 'https://smart-pager-web.vercel.app/api/restaurants/';
  
  ApiService(this.httpClient);
  
  Future<void> getHello() async {
    final response = await httpClient.get(Uri.parse("${baseUrl}/franco-rodriguez-2/queue"));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
