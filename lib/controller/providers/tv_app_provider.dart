import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movies_application/core/constance/app_constance.dart';
import 'package:http/http.dart' as http;
import 'package:movies_application/models/tv_search_model.dart';

class TvAppProvider extends ChangeNotifier {
  Future getAiringTodayData() async {
    var getAiringTodayUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/airing_today?api_key=${AppConstance.apiKey}&language=en-US&page=1');
    var response = await http.get(getAiringTodayUrl);
    return json.decode(response.body)['results'];
  }

  Future getTvPopularData() async {
    var getTvPopularDataUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/popular?api_key=${AppConstance.apiKey}&language=en-US&page=1');
    var response = await http.get(getTvPopularDataUrl);
    return json.decode(response.body)['results'];
  }

  Future getTvTopRatedData() async {
    var getTvTopRatedUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/top_rated?api_key=${AppConstance.apiKey}&language=en-US&page=1');
    var response = await http.get(getTvTopRatedUrl);
    return json.decode(response.body)['results'];
  }

  Future getSeriesDetailsDate({
    int seriesId,
  }) async {
    var getSeriesDetailsUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/${seriesId}?api_key=${AppConstance.apiKey}&language=en-US');
    var response = await http.get(getSeriesDetailsUrl);
    return json.decode(response.body);
  }

  Future getSeriesArabicDetailsDate({
    int seriesId,
  }) async {
    var getSeriesArabicDetailsUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/${seriesId}?api_key=${AppConstance.apiKey}&language=ar-EG');
    var response = await http.get(getSeriesArabicDetailsUrl);
    return json.decode(response.body);
  }

  Future getTvRecommendationData({
    int seriesId,
  }) async {
    var getTvRecommendationDataUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/${seriesId}/recommendations?api_key=${AppConstance.apiKey}&language=en-US&page=1');
    var response = await http.get(getTvRecommendationDataUrl);
    return json.decode(response.body)['results'];
  }

  Future getTvSearchData({
    String query,
  }) async {
    var getTvSearchUrl = Uri.parse(
        '${AppConstance.baseUrl}search/tv?api_key=${AppConstance.apiKey}&language=en-US&page=1&query=$query');
    var response = await http.get(getTvSearchUrl);
    return TvSearchModel.fromJson(json.decode(response.body));
  }

  Future geTvReviewsData({
    int seriesId,
  }) async {
    var getTvReviewsUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/$seriesId/reviews?language=en-US&page=1&api_key=${AppConstance.apiKey}');
    var response = await http.get(getTvReviewsUrl);
    return json.decode(response.body)['results'];
  }

  Future getSeasonsDetailsData({
    int seriesId,
    int seasonNumber,
  }) async {
    var getSeasonsDetailsUrl = Uri.parse(
        '${AppConstance.baseUrl}tv/$seriesId/season/$seasonNumber?api_key=${AppConstance.apiKey}&language=en-US');
    var response = await http.get(getSeasonsDetailsUrl);
    return json.decode(response.body);
  }

//   Future getTvEpisodesImagesData({
//     int seriesId,
//     int seasonNumber,
//     int episodeNumber,
// }) async {
//     var getTvEpisodesImagesData = Uri.parse(
//       '${AppConstance.baseUrl}tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/images?api_key=${AppConstance.apiKey}');
//     var response = await http.get(getTvEpisodesImagesData);
//     return json.decode(response.body);
//   }

  // Future getEpisodesDetailsData({
  //   int seriesId,
  //   int seasonNumber,
  //   int episodeNumber,
  // }) async {
  //   var getEpisodesDetailsUrl = Uri.parse(
  //       '${AppConstance.baseUrl}tv/$seriesId/season/$seasonNumber/episode/$episodeNumber?api_key=${AppConstance.apiKey}&language=en-US');
  //   var response = await http.get(getEpisodesDetailsUrl);
  //   return json.decode(response.body);
  // }

}
