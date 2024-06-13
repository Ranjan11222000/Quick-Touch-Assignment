import 'dart:convert';
import 'package:http/http.dart'as http;

class NetworkApiService {

  Future getApiResponseWithQuery(
      String url, Map<String, dynamic> queryParameters) async {
    dynamic responseJson;

    try {
      String queryString = Uri(queryParameters: queryParameters).query;
      final response = await http.get(
        Uri.parse('$url?$queryString'), // Append the query string to the URL
        headers: {
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } catch(e) {
      rethrow;
    }

    return responseJson;
  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
    }
  }

}