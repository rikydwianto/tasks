import 'package:intl/intl.dart';

class TanggalHelper {
  // Fungsi untuk memformat tanggal ISO ke format Indonesia
  static String formatFromIso(String isoDate) {
    try {
      final DateTime dateTime = DateTime.parse(isoDate);
      final DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
      return dateFormat.format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return "Invalid Date";
    }
  }

  // Fungsi untuk memformat tanggal dan waktu
  static String formatFullDateTime(String isoDate) {
    try {
      final DateTime dateTime = DateTime.parse(isoDate);
      final DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm', 'id_ID');
      return dateFormat.format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return "Invalid Date";
    }
  }
}
