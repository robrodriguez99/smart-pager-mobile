import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/data/models/user_model.dart';

class ApiService {
  final http.Client httpClient;
  String baseUrl = "https://smart-pager-web.vercel.app/api/restaurants";
  
  ApiService(this.httpClient);
  
  Future<void> getHello() async {
    final response = await httpClient.get(Uri.parse("${baseUrl}/franco-rodriguez-2/queue"));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  
  /// POST /api/restaurants/[slug]/queue
  ///
  /// Path Parameters:
  ///  - slug (string): The unique identifier for the restaurant.
  ///
  /// Payload Parameters:
  ///  - client (object): Contains the necessary details about the client 
  /// making the reservation.
  ///    - email (string): The client's email address, which must be a valid 
  /// email format.
  ///    - name (string): The client's full name.
  ///    - commensalsAmount (string): The total number of diners included in
  /// the reservation.
  ///    - phoneNumber (string): The client's contact phone number.
  ///    - description (string, optional): Any additional information about 
  /// the reservation that the client wishes to provide.
  ///
  Future<void> addToQueue(String restaurantSlug, SmartPagerUser user, String description, int commensalsAmount ) async {
    final response = await httpClient.post(
    Uri.parse("$baseUrl/$restaurantSlug/queue"), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "client": {
        "email": user.email,
        "name": user.name,
        "commensalsAmount": commensalsAmount,
        "phoneNumber": "541136059399", //TODO: Add phone number to user model
        "description": description
      }
    }),
    );
    
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to add to queue');
    }
  }

      
  /// GET /api/restaurants?search=restaurantName&page=number&pageSize=number
  ///
  /// page y pageSize son opcionales y defaultean a 0 y 10
  /// search es opcional tmb
  Future<List<SmartPagerRestaurant>> getRestaurants({String? search, int page = 0, int pageSize = 10}) async {
    search ??= "";
    final response = await httpClient.get(Uri.parse("$baseUrl?search=$search&page=$page&pageSize=$pageSize"));
    Map<String, dynamic> json = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    List<SmartPagerRestaurant> restaurants = [];
    for (var restaurant in json['restaurants']) {
      restaurants.add(SmartPagerRestaurant.fromJson(restaurant));
    }
    return restaurants;
  }

  /// GET /api/restaurants/[slug]
  Future<SmartPagerRestaurant> getRestaurant(String slug) async {
    final response = await httpClient.get(Uri.parse("$baseUrl/$slug"));
    Map<String, dynamic> json = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    return SmartPagerRestaurant.fromJson(json['restaurant']);
  }

}
