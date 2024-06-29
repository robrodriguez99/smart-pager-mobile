import 'package:smart_pager/data/models/generic_model.dart';
import 'package:smart_pager/data/models/operating_hours_model.dart';

class SmartPagerRestaurant extends GenericModel<SmartPagerRestaurant> {
  final String slug;
  final String name;
  final String email;
  //the following fields might be null
  final String? type; //comida japonesa
  final String? avgTimePerTable; //30
  final bool isPromoted;
  final location;
  final menu;
  final RestaurantOperatingHours? operatingHours; 
  //TODO: add field types

  SmartPagerRestaurant({
    required super.id,
    required this.slug,
    required this.name,
    required this.email,
    required this.type,
    required this.avgTimePerTable,
    required this.isPromoted,
    this.location,
    this.menu,
    this.operatingHours,
  });

  
  static SmartPagerRestaurant fromJson(Map<String, dynamic> json) {
    return SmartPagerRestaurant(
      id: json['slug'] ?? "no_id",
      slug: json['slug'] ?? "no_slug",
      name: json['name'] ?? "no_name",
      email: json['email'] ?? "no_email",
      type: json['type'] ?? "no_type",
      avgTimePerTable: json['avgTimePerTable'] ?? "no_time",
      isPromoted: json['sponsored'] ?? false,
      location: json['location'] ?? "no_location",
      menu: json['menu'] ?? "no_menu",
      operatingHours: _parseOperatingHours(json['operatingHours']),
    );
  }



  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'email': email,
      'type': type,
      'avgTimePerTable': avgTimePerTable,
      'isPromoted': isPromoted,
      'location': location,
      'menu': menu,
      'operatingHours': operatingHours,
    };
  }

  SmartPagerRestaurant copy() {
    return SmartPagerRestaurant(
      id: id,
      slug: slug,
      name: name,
      email: email,
      type: type,
      avgTimePerTable: avgTimePerTable,
      isPromoted: isPromoted,
      location: location,
      menu: menu,
      operatingHours: operatingHours,
    );
  }

  static RestaurantOperatingHours? _parseOperatingHours(dynamic json) {
    if (json == null) {
      return null;
    }
    return RestaurantOperatingHours.fromJson(json);
  }

}


