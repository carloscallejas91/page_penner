import "dart:convert";

class MyNotes {
  final String? recommendedBy;
  final String? startReading;
  final String? endReading;
  final String? notes;
  final int? stars;
  final double? value;

  MyNotes({
    this.recommendedBy,
    this.startReading,
    this.endReading,
    this.notes,
    this.stars,
    this.value,
  });

  factory MyNotes.fromRawJson(String str) =>
      MyNotes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyNotes.fromJson(Map<dynamic, dynamic> json) =>
      MyNotes(
        recommendedBy: json["recommended_by"],
        startReading: json["start_reading"],
        endReading: json["end_reading"],
        notes: json["notes"],
        stars: json["stars"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "recommendedBy": recommendedBy,
        "startReading": startReading,
        "endReading": endReading,
        "notes": notes,
        "notes": stars,
        "value": value,
      };
}
