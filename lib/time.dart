import 'package:intl/intl.dart';

void main() {
  const String dateTime = '2024-07-22 01:00';
  DateTime dateee = DateTime.parse(dateTime);
  String date = DateFormat('hh:mm').format(dateee);
  print(date);
}
