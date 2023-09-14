import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_application/models/newschannelsheadlinesmodel.dart'; // for JSON decoding

class NewsRepositery {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlineApi() async {
    // const apiKey = '71e3c4580fb4422fb138e63093be3c21';
    // const url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    String url =
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=71e3c4580fb4422fb138e63093be3c21";

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:news_application/models/newschannelsheadlinesmodel.dart';

// Future<List<dynamic>> fetchData() async {
//   final response = await http.get(
//     Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=71e3c4580fb4422fb138e63093be3c21'),
//   );

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     return data['articles'];
//   } else {
//     throw Exception('Failed to load data');
//   }
// }


