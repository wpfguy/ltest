import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_project/models/feed_request.dart';
import 'package:test_project/models/feed_response.dart';
import 'package:test_project/models/login_response.dart';

class APIProvider {
  static const String baseUri = 'https://app-test.rr-qa.seasteaddigital.com';
  static const String deviceId = '7789e3ef-c87f-49c5-a2d3-5165927298f0';

  static Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse('$baseUri/app_api/auth.php');

    Map<String, String> requestBody = <String, String>{
      'device_id': deviceId,
      'email': username,
      'password': password
    };
    var request = MultipartRequest('POST', url)..fields.addAll(requestBody);
    var response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      return LoginResponse.fromJson(jsonDecode(responseString));
    } else {
      throw Exception('Login Failed');
    }
  }

  static Future<FeedResponse> getFeedPage(
      int pageSize, String order, int lastPostId, String authToken) async {
    final url = Uri.parse('$baseUri/api/v1/posts/feed/global.json');

    var feedRequest = FeedRequest(
      data: FeedRequestData(
        pageSize: pageSize,
        order: order,
        lastPostId: lastPostId,
      ),
    );

    var response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-APP-AUTH-TOKEN': authToken,
        'X-DEVICE-ID': deviceId
      },
      body: jsonEncode(feedRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return FeedResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Feed request failed');
    }
  }
}
