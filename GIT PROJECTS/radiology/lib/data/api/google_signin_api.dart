import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class GoogleSignInApi {
  Future<dynamic> get({
    required String idToken,
  }) async {
    var headers = {
      'Authorization': 'Bearer 799|k2X77qJMvQs7zxDS5qkC7LmJ66IPdOYuxaOKbWQZ50bf3d80',
      'Accept': 'application/json',
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://lab2.invoidea.in/outlier/api/google-login?token=$idToken')
    );
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      return jsonDecode(responseBody);
    } else {
      print('Error: ${response.reasonPhrase}');
      return false;
    }
  }
}
