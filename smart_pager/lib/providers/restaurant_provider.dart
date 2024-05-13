import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/services/api_service.dart';
import 'package:http/http.dart' as http;


final apiServiceProvider = Provider((ref) => ApiService(http.Client()));


final helloProvider = FutureProvider<void>((ref) async {
  await ref.read(apiServiceProvider).getHello();
});