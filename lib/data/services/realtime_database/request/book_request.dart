import "package:page_penner/data/models/my_notes.dart";
import "package:page_penner/data/models/volume_information.dart";

class BookRequest {
  final MyNotes? myNotes;
  final VolumeInformation? volumeInformation;

  BookRequest({
    this.myNotes,
    this.volumeInformation,
  });

  Map<String, dynamic> toJson() => {
        "my_notes": myNotes?.toJson(),
        "volume_info": volumeInformation?.toJson(),
      };
}
