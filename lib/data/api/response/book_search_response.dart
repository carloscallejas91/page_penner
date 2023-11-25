import "dart:convert";

import "package:page_penner/data/models/volume_information.dart";

class BooksSearchResponse {
  final int? totalItems;
  final List<Book>? items;

  BooksSearchResponse({
    this.totalItems,
    this.items,
  });

  factory BooksSearchResponse.fromRawJson(String str) =>
      BooksSearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksSearchResponse.fromJson(Map<String, dynamic> json) =>
      BooksSearchResponse(
        totalItems: json["totalItems"],
        items: json["items"] == null
            ? []
            : List<Book>.from(json["items"]!.map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Book {
  final String? selfLink;
  final VolumeInformation? volumeInformation;

  Book({
    this.selfLink,
    this.volumeInformation,
  });

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        selfLink: json["selfLink"],
        volumeInformation: json["volumeInfo"] == null
            ? null
            : VolumeInformation.fromJson(json["volumeInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "selfLink": selfLink,
        "volumeInfo": volumeInformation?.toJson(),
      };
}
