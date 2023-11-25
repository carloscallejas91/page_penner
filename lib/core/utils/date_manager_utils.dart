import "package:intl/intl.dart";

mixin DateManagerUtils {
  static String formatDate(String? date) {
    final DateFormat formatter = DateFormat("dd/MM/yyyy");
    if (date != null) {
      return formatter.format(DateTime.parse(date));
    } else {
      return "--/--/--";
    }
  }
}
