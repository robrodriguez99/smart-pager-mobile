
import 'package:smart_pager/data/models/restaurant_model.dart';

class TimerService {

  bool checkIfRestaurantIsClosed(SmartPagerRestaurant restaurant) {
    // Get the current time in GMT-3
    DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 3));

    if (restaurant.operatingHours == null) {
     
      return false;
    }

    // Get the current day of the week
    String currentDay = _getDayOfWeek(now.weekday);

    // Get the operating hours for the current day
    final dayData = restaurant.operatingHours!.days[currentDay];

    if (dayData == null) {
      return false;
    }
    if (!dayData.isOpen) {
      return true;
    }

    // Check if the current time falls within any of the intervals
    for (var interval in dayData.intervals) {
      DateTime openingTime = _getDateTimeFromTimeString(
        interval.openingTime,
        now,
      );
      print("openingTime: $openingTime");
      DateTime closingTime = _getDateTimeFromTimeString(
        interval.closingTime,
        now,
      );
      print("closingTime: $closingTime");

      // If the closing time is before the opening time, it means the closing time is on the next day
      if (closingTime.isBefore(openingTime)) {
        closingTime = closingTime.add(const Duration(days: 1));
      }

      if (now.isAfter(openingTime) && now.isBefore(closingTime)) {
        return false;
      }
    }
      return true;
  }

  DateTime _getDateTimeFromTimeString(
      String timeString, DateTime referenceDate) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    return DateTime(referenceDate.year, referenceDate.month, referenceDate.day,
        hours, minutes);
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

}