import 'dart:convert';

import 'package:intl/intl.dart';

class ShipmentModel {
  final String? id;
  final String title;
  final DateTime date;
  final bool completed;
  final double rated;
  final double latitude; // خط العرض
  final double longitude; // خط الطول

  ShipmentModel({
    this.id,
    required this.title,
    required this.date,
    required this.completed,
    required this.rated,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'completed': completed,
      'rated': rated,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory ShipmentModel.fromMap(Map<String, dynamic> map) {
    return ShipmentModel(
      id: map['id'] ?? '',
      title: map['title'] as String,
      date: DateTime.parse(map['date'] as String),
      completed: map['completed'] as bool,
      rated: (map['rated'] as num).toDouble(),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipmentModel.fromJson(String source) =>
      ShipmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ShipmentModel copyWith({
    String? id,
    String? title,
    DateTime? date,
    bool? completed,
    double? rated,
    double? latitude,
    double? longitude,
  }) {
    return ShipmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      rated: rated ?? this.rated,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

String formatDate(DateTime date) {
  DateTime today = DateTime.now();

  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    return "اليوم ${formatTime(date)}"; // عرض الوقت فقط إذا كان اليوم
  }
  return DateFormat(
    'dd/MM/yyyy',
  ).format(date); // عرض التاريخ فقط لغير اليوم
}

String formatTime(DateTime date) {
  return DateFormat(
    'hh:mm a',
  ).format(date).replaceAll("AM", "ص").replaceAll("PM", "م");
}

List<ShipmentModel> shipments = [
  ShipmentModel(
    title: "أحمد القرعاوي",
    date: DateTime(2025, 3, 26, 14, 30),
    completed: false,
    rated: 0,
    latitude: 24.774265,
    longitude: 46.738586,
  ),
  ShipmentModel(
    title: "جو بايدن",
    date: DateTime(2024, 6, 11, 14, 30),
    completed: false,
    rated: 0,
    latitude: 24.774265,
    longitude: 46.738586,
  ),
  ShipmentModel(
    title: "عمرو دياب",
    date: DateTime(2024, 2, 23),
    completed: true,
    rated: 0, // تم الإلغاء
    latitude: 30.044420,
    longitude: 31.235712,
  ),
  ShipmentModel(
    title: "ياسر عرفات",
    date: DateTime(2024, 2, 23),
    completed: true,
    rated: 5,
    latitude: 31.768319,
    longitude: 35.213710,
  ),
  ShipmentModel(
    title: "عمرو الليسي",
    date: DateTime(2024, 2, 23),
    completed: true,
    rated: 0,
    latitude: 32.887209,
    longitude: 13.191338,
  ),
];
