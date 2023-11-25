import "dart:convert";

class VolumeInformation {
  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final int? pageCount;
  final ImageLinks? imageLinks;
  final String? previewLink;
  final String? infoLink;

  VolumeInformation({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.imageLinks,
    this.previewLink,
    this.infoLink,
  });

  factory VolumeInformation.fromRawJson(String str) =>
      VolumeInformation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VolumeInformation.fromJson(Map<dynamic, dynamic> json) =>
      VolumeInformation(
        title: json["title"],
        authors: json["authors"] == null
            ? []
            : List<String>.from(json["authors"]!.map((x) => x)),
        publisher: json["publisher"],
        publishedDate: json["publishedDate"],
        description: json["description"],
        pageCount: json["pageCount"],
        imageLinks: json["imageLinks"] == null
            ? null
            : ImageLinks.fromJson(json["imageLinks"]),
        previewLink: json["previewLink"],
        infoLink: json["infoLink"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "authors":
            authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
        "publisher": publisher,
        "publishedDate": publishedDate,
        "description": description,
        "pageCount": pageCount,
        "imageLinks": imageLinks?.toJson(),
        "previewLink": previewLink,
        "infoLink": infoLink,
      };
}

class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;
  final String? small;
  final String? medium;
  final String? large;
  final String? extraLarge;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
    this.small,
    this.medium,
    this.large,
    this.extraLarge,
  });

  factory ImageLinks.fromRawJson(String str) =>
      ImageLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageLinks.fromJson(Map<dynamic, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
        extraLarge: json["extraLarge"],
      );

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
        "small": small,
        "medium": medium,
        "large": large,
        "extraLarge": extraLarge,
      };
}
