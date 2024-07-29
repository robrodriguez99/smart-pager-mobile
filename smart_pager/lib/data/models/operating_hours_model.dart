//operating hours example
  // "operatingHours": {
  //               "Lunes": {
  //                   "isOpen": true,
  //                   "intervals": [
  //                       {
  //                           "closingTime": "23:59",
  //                           "openingTime": "17:00"
  //                       }
  //                   ]
  //               },
  //               "Jueves": {
  //                   "isOpen": true,
  //                   "intervals": [
  //                       {
  //                           "closingTime": "18:00",
  //                           "openingTime": "09:30"
  //                       }
  //                   ]
  //               },
  //               "Martes": {
  //                   "isOpen": true,
  //                   "intervals": [
  //                       {
  //                           "closingTime": "13:00",
  //                           "openingTime": "09:00"
  //                       },
  //                       {
  //                           "closingTime": "23:59",
  //                           "openingTime": "18:00"
  //                       }
  //                   ]
  //               },
  //               "Domingo": {
  //                   "isOpen": true,
  //                   "intervals": [
  //                       {
  //                           "closingTime": "22:30",
  //                           "openingTime": "10:30"
  //                       }
  //                   ]
  //               },
  //               "Sábado": {
  //                   "isOpen": true,
  //                   "intervals": [
  //                       {
  //                           "closingTime": "23:14",
  //                           "openingTime": "00:14"
  //                       }
  //                   ]
  //               },
  //               "Viernes": {
  //                   "isOpen": false,
  //                   "intervals": []
  //               },
  //               "Miércoles": {
  //                   "isOpen": false,
  //                   "intervals": []
  //               }
  //           },

import 'package:smart_pager/data/models/generic_model.dart';

class RestaurantOperatingHours extends GenericModel<RestaurantOperatingHours> {
  final Map<String, RestaurantOperatingDay> days;

  RestaurantOperatingHours({
    required super.id,
    required this.days,
  });

  static RestaurantOperatingHours fromJson(Map<String, dynamic> json) {
    return RestaurantOperatingHours(
      id: json['id'] ?? "no_id",
      days: _parseDays(json),
    );
  }


  static Map<String, RestaurantOperatingDay> _parseDays(dynamic json) {
    if (json is Map) {
      return json.map((key, value) {
        return MapEntry(key, RestaurantOperatingDay.fromJson(value));
      });
    }
    return {};
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'days': days,
    };
  }
}

class RestaurantOperatingDay extends GenericModel<RestaurantOperatingDay> {
  final bool isOpen;
  final List<Interval> intervals;

  RestaurantOperatingDay({
    required super.id,
    required this.isOpen,
    required this.intervals,
  });

  static RestaurantOperatingDay fromJson(Map<String, dynamic> json) {
    return RestaurantOperatingDay(
      id: json['id'] ?? "no_id",
      isOpen: json['isOpen'] ?? false,
      intervals: _parseIntervals(json['intervals']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'isOpen': isOpen,
      'intervals': intervals,
    };
  }

  static List<Interval> _parseIntervals(dynamic json) {
    if (json is List) {
      return json.map((intervalJson) => Interval.fromJson(intervalJson)).toList();
    }
    return [];
  }
}

class Interval extends GenericModel<Interval> {
  final String closingTime;
  final String openingTime;

  Interval({
    required super.id,
    required this.closingTime,
    required this.openingTime,
  });

  static Interval fromJson(Map<String, dynamic> json) {
    return Interval(
      id: json['id'] ?? "no_id",
      closingTime: json['closingTime'] ?? "no_closingTime",
      openingTime: json['openingTime'] ?? "no_openingTime",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'closingTime': closingTime,
      'openingTime': openingTime,
    };
  }
}