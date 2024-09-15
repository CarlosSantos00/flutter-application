import 'package:intl/intl.dart';

class FeriadoModel {
  final String name;
  final String date;

  FeriadoModel({required this.name, required this.date});

  factory FeriadoModel.fromJson(Map<String, dynamic> json) {
    return FeriadoModel(
      name: json['name'],
      date: json['date'],
    );
  }

String get formattedDate {
  DateTime dateTime = DateTime.parse(date);
  final DateFormat formatter = DateFormat('dd/MM/yyyy'); //formatar data
  return formatter.format(dateTime);
}

}
