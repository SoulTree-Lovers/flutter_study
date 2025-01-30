import '../const/data.dart';

class DataUtils {
  static pathToUrl(String value) {
    return 'http://$ip$value';
  }

  // List<dynamic>을 받아 List<String>으로 변환하는 메서드
  static List<String> listPathsToUrls(List<dynamic> values) {
    return values
        .map((value) => pathToUrl(value)) // URL 변환
        .toList()
        .cast<String>(); // List<String>으로 변환
  }
}