import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_application/models/search_model.dart';
import '../../core/constance/app_constance.dart';

class AppProvider extends ChangeNotifier {
  var getNowPlayingUrl = Uri.parse(
      '${AppConstance.baseUrl}movie/now_playing?api_key=${AppConstance.apiKey}&language=en-US&page=1');

  Future getNowPlayingData() async {
    var response = await http.get(getNowPlayingUrl);
    return json.decode(response.body)['results'];
  }

  Future getPopularMoviesData() async {
    var getPopularMoviesUrl = Uri.parse(
      '${AppConstance.baseUrl}movie/popular?api_key=${AppConstance.apiKey}&language=en-US&language=en-US',
    );

    http.Response response = await http.get(getPopularMoviesUrl);
    return json.decode(response.body)['results'];
  }

  var getTopRatedUrl = Uri.parse(
    '${AppConstance.baseUrl}movie/top_rated?api_key=${AppConstance.apiKey}&language=en-US&page=1',
  );

  Future getTopRatedData() async {
    var response = await http.get(getTopRatedUrl);
    return json.decode(response.body)['results'];
  }

  Future getMoviesDetailsData({
    @required movieId,
  }) async {
    var getMoviesDetailsUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/${movieId}?api_key=${AppConstance.apiKey}&language=en-US',
    );
    var response = await http.get(getMoviesDetailsUrl);
    return json.decode(response.body);
  }

  // var getTrendingMoviesUrl = Uri.parse(
  //   '${AppConstance.baseUrl}trending/all/day?api_key=${AppConstance.apiKey}',
  // );
  //
  // Future getTrendingMoviesData() async {
  //   var response = await http.get(getTrendingMoviesUrl);
  //   return json.decode(response.body)['results'];
  // }

  Future getMoviesArabicData({
    @required movieId,
  }) async {
    var getMoviesDetailsUrl = Uri.parse(
      'https://api.themoviedb.org/3/movie/${movieId}?api_key=${AppConstance.apiKey}&language=ar-EG',
    );
    var response = await http.get(getMoviesDetailsUrl);
    return json.decode(response.body);
  }

  Future getMovieReviews({
    @required movieId,
  }) async {
    var getMovieReviewsUrl = Uri.parse(
      '${AppConstance.baseUrl}movie/${movieId}/reviews?api_key=${AppConstance.apiKey}&language=en-US&page=1',
    );
    var response = await http.get(getMovieReviewsUrl);
    return json.decode(response.body)['results'];
  }

  Future getRecommendationsMovies({
    @required movieId,
  }) async {
    var getRecommendationsMoviesUrl = Uri.parse(
      '${AppConstance.baseUrl}movie/${movieId}/recommendations?api_key=${AppConstance.apiKey}&language=en-US&page=1',
    );
    var response = await http.get(getRecommendationsMoviesUrl);
    return json.decode(response.body)['results'];
  }

  Future getSearchData({
    @required query,
  }) async {
    var getSearchDataUrl = Uri.parse(
      '${AppConstance.baseUrl}search/movie?api_key=${AppConstance.apiKey}&language=en-US&query=${query}',
    );
    var response = await http.get(getSearchDataUrl);
    return SearchModel.fromJson((json.decode(response.body)));

  }
}
