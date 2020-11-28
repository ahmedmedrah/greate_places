import 'package:http/http.dart' as http;
import 'dart:convert';
class LocationHelper {

  /// get a map image preview using lat and long
  static String generateLocationPreviewImage(double lat, double long) {
    return 'https://static-maps.yandex.ru/1.x/?lang=en_US&ll=$long,$lat&size=450,450&z=15&l=map&pt=$long,$lat,pm2rdm';
  }

  /// get the place address using lat and long
  static Future<String> getPlaceAddress(double lat, double long) async{

    final url = 'https://us1.locationiq.com/v1/reverse.php?key=$apiKey&format=json&lat=$lat&lon=$long';
    final response = await http.get(url);
    print(json.decode(response.body)['display_name']);
    return json.decode(response.body)['display_name'];
  }
}
