import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

const String ENC_KEY =
    'key';
const String BASE_URL = 'https://api.shipment_tracker.co.ke/api';

// baseURL : "https://test.shipment_tracker.co.ke/api"  //test
            // baseURL : "https://api.shipment_tracker.co.ke/api/"  //production
            // baseURL : "http://127.0.0.1:8000/api/"    //local

class ApiService {
  static Future<List<dynamic>> makeRequest({
    required String url,
    required String method,
    dynamic data = null,
    bool useJwt = false,
  }) async {
    url = BASE_URL + url;
    Map<String, String> headers = {
      "accept": "*/*",
    };
    print('endpoint $url');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // dynamic? user = prefs.getString('user');
    // String token = user['token'];

    // final updateUserSession = () {
    //   if (user != null) {
    //     prefs.setString('user', user);
    //   }
    // };
      String? token = prefs.getString('user_token');

     final updateUserSession = () {
      if (token != null) {
        prefs.setString('user_token', token);
      }
    };

    String? jwt;

    if (useJwt) {
      final Map<String, dynamic> payload = {
        ...data,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000 + (1 * 60),
      };

      final Map<String, dynamic> header = {
        "typ": "JWT",
        "alg": "HS256",
      };

      jwt = sign(payload, ENC_KEY, header);
      url += (url.contains('?') ? '&' : '?') + 'token=' + jwt;
      // final data_value = {
      //   "token": jwt,
      // };
      // data = data_value;
      data = null;
    } else {
      headers = {
        ...headers,
        ...{"content-type": "application/json"}
      };
    }

    if (token != null) {
      headers = {
        ...headers,
        ...{'Authorization': 'Bearer $token'}
      };
    }

    headers = {
      ...headers,
      'referrer-policy': 'no-referrer',
      'redirect': 'follow',
      'mode': 'cors',
      'cache': 'no-cache',
      // Add more custom headers as needed for cache, redirect, etc.
    };

    try {
      http.Response response;
      if (method == 'GET') {
        response = await http.Client().get(
          Uri.parse(url),
          headers: headers,
        );
      } else if (method == 'POST') {
        response = await http.Client().post(
          Uri.parse(url),
          headers: headers,
          body: data != null ? jsonEncode(data) : null,
        );
      } else {
        throw Exception('Unsupported HTTP method: $method');
      }
      final dynamic decoded = json.decode(response.body);
      final int? status = response.statusCode;
      if (decoded is List) {
        return [status, decoded];
      } else {
        final Map<String, dynamic> result = json.decode(response.body);
        return [status, result];
      }
    } catch (err) {
      final int? status = err is http.Response ? err.statusCode : null;
      final Map<String, dynamic> result = err is http.Response
          ? json.decode(err.body)
          : {'error': 'An error occurred'};
      return [status, result];
    } finally {
      updateUserSession();
    }
  }

  static String sign(Map<String, dynamic> payload, String secret,
      Map<String, dynamic> header) {
    final String encodedHeader =
        base64UrlEncode(utf8.encode(jsonEncode(header)));
    final String encodedPayload =
        base64UrlEncode(utf8.encode(jsonEncode(payload)));
    final String signatureInput = '$encodedHeader.$encodedPayload';
    final List<int> signatureBytes = Hmac(sha256, utf8.encode(secret))
        .convert(utf8.encode(signatureInput))
        .bytes;
    final String encodedSignature = base64UrlEncode(signatureBytes);

    return '$signatureInput.$encodedSignature';
  }
}
