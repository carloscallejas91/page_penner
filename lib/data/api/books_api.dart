import "package:get/get.dart";
import "package:page_penner/core/configs/config.dart";
import "package:page_penner/core/rest/rest_http.dart";
import "package:page_penner/data/api/response/about_book_response.dart";
import "package:page_penner/data/api/response/book_search_response.dart";

class BooksApi {
  final RestHttp _restHttp = Get.find<RestHttp>();

  Future<BooksSearchResponse> getBooks(String title) async {
    final response = await _restHttp.make().get(
        "q=intitle:$title&printType=books&orderBy=relevance&langRestrict=pt&maxResults=40&key=${Config.keyGoogleBooks}");

    try {
      return BooksSearchResponse.fromRawJson(response.data as String);
    } catch (e, s) {
      throw Exception("Exception $e $s");
    }
  }

  Future<AboutBookResponse> getBook(String url) async {
    final response = await _restHttp.make().get(url);

    try {
      return AboutBookResponse.fromRawJson(response.data as String);
    } catch (e, s) {
      throw Exception("Exception $e $s");
    }
  }
}
