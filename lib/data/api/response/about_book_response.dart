// To parse this JSON data, do
//
//     final bookResponse = bookResponseFromJson(jsonString);

import "dart:convert";

import "package:page_penner/data/models/volume_information.dart";

class AboutBookResponse {
  final VolumeInformation? volumeInformation;

  AboutBookResponse({
    this.volumeInformation,
  });

  factory AboutBookResponse.fromRawJson(String str) =>
      AboutBookResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AboutBookResponse.fromJson(Map<String, dynamic> json) =>
      AboutBookResponse(
        volumeInformation: json["volumeInfo"] == null
            ? null
            : VolumeInformation.fromJson(json["volumeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "volumeInfo": volumeInformation?.toJson(),
      };
}
