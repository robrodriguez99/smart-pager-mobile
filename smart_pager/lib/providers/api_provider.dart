import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/services/api_service.dart';
import 'package:http/http.dart' as http;

part 'api_provider.g.dart';

@riverpod
ApiService apiService(ApiServiceRef ref) {
  return ApiService(http.Client());
}

