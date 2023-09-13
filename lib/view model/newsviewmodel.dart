import 'package:flutter/material.dart';
import 'package:news_application/models/newschannelsheadlinesmodel.dart';
import 'package:news_application/repositery/newsrepositery.dart';

class NewsViewModel {
  final repo = NewsRepositery();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await repo.fetchNewsChannelHeadlineApi();
    return response;
  }
}
