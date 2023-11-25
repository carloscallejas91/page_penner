// To parse this JSON data, do
//
//     final wishListResponse = wishListResponseFromJson(jsonString);

import "dart:convert";

import "package:page_penner/data/models/volume_information.dart";

class BookListResponse {
  final String? id;
  final VolumeInformation? itemInformation;

  BookListResponse({
    this.id,
    this.itemInformation,
  });

  String toRawJson() => json.encode(toJson());

  factory BookListResponse.fromJson(String id, Map<dynamic, dynamic> json) {
    return BookListResponse(
      id: id,
      itemInformation: json["volume_info"] == null
          ? null
          : VolumeInformation.fromJson(json["volume_info"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "volume_info": itemInformation?.toJson(),
      };
}
