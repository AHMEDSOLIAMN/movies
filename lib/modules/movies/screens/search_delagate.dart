import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/app_provider.dart';
import 'package:movies_application/core/constance/app_constance.dart';
import 'package:movies_application/models/search_model.dart';
import 'package:movies_application/modules/movies/screens/movies_details_screen.dart';
import 'package:movies_application/modules/movies/screens/movies_see_more_details_screen.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.yellow[400],
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        }
        return {
          query = '',
        };
      },
      icon: Icon(
        Icons.clear,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    Icon(IconlyBroken.arrow_left_2);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, controller, child) {
        return FutureBuilder(
          future: controller.getSearchData(query: query),
          builder: (context, snapshot) {
            SearchModel data = snapshot.data;
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your search - ${query} - did not match any Movie',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Image.asset(
                    'assets/images/no-results.png',
                    color: Colors.white,
                    height: 200,
                    width: 200,
                  )),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.separated(
              itemCount: data.results.length,
              separatorBuilder: (context, index) => Container(
                height: 0.1,
                width: double.infinity,
                color: Colors.yellow,
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviesSeeMoreDetailsScreen(
                          movieId: data.results[index].id,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      if (data.results[index].posterPath != null)
                        Row(
                          children: [
                            Card(
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image(
                                image: NetworkImage(
                                  '${AppConstance.photosBaseUrl}${data.results[index].posterPath}',
                                ),
                                height: 150,
                                width: 100,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 280,
                                  child: Text(
                                    '${data.results[index].title}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconlyBold.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "${data.results[index].voteAverage}/10",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "(${data.results[index].voteCount})",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 280,
                                  child: Text(
                                    '${data.results[index].overview}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SearchModel> suggestion = [];
    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          '${suggestion[index].results[index].title}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
