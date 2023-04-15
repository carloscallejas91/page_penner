import "package:intl/intl.dart";

class DateManagerUtils {
  final DateFormat formatter = DateFormat("dd/MM/yyyy");

  String formatDate(String date) {
    return formatter.format(DateTime.parse(date));
  }

  DateTime getFirstDayMonth() {
    return DateTime(
      DateTime.now().year, // year
      DateTime.now().month, // month
      1, // day
      0, // hour
      0, // second
      0, // millisecond
    );
  }

  DateTime getLastDayMonth() {
    return DateTime(
      DateTime.now().year, // year
      DateTime.now().month + 1, // month
      0, // day
      23, // hour
      59, // second
      59, // millisecond
    );
  }
}
