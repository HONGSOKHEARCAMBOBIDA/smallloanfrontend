import 'package:intl/intl.dart';
class CustomDateUti {
  /// Parses a date string into DateTime.
  /// Supports ISO format and custom format "yyyy-MM-dd'T'HH:mm:ssZ"
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    try {
      // Try default ISO parse
      return DateTime.parse(dateString);
    } catch (_) {
      try {
        // Try custom format
        return DateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
            .parse(dateString, true)
            .toLocal();
      } catch (_) {
        return null;
      }
    }
  }
}
