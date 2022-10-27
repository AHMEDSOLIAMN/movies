import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/app_provider.dart';
import 'package:movies_application/core/constance/app_constance.dart';
import 'package:movies_application/modules/movies/screens/more_like_this_details_screen.dart';
import 'package:movies_application/modules/movies/screens/movies_see_more_details_screen.dart';
import 'package:provider/provider.dart';

class MoviesDetailsScreen extends StatelessWidget {
  final movieId;

  const MoviesDetailsScreen({
    Key key,
    this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:
          SystemUiOverlayStyle(statusBarColor: Colors.black.withOpacity(0.2)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Consumer<AppProvider>(
          builder: (context, controller, child) {
            return FutureBuilder(
              future: Future.wait([
                controller.getMoviesDetailsData(movieId: movieId),
                controller.getMoviesArabicData(movieId: movieId),
                // controller.getMovieReviews(movieId: popularMovieId),
                controller.getRecommendationsMovies(movieId: movieId),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    // fromLTRB
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.5, 0.2, 1],
                                ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image(
                                image: NetworkImage(
                                  '${AppConstance.photosBaseUrl}${snapshot.data[0]['poster_path']}',
                                ),
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 50,
                                  left: 10,
                                ),
                                child: Icon(
                                  IconlyBroken.arrow_left_2,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 15,
                          ),
                          child: SizedBox(
                            width: 400,
                            child: Text(
                              '${snapshot.data[0]['title']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      width: 35,
                                      child: Text(
                                        '${snapshot.data[0]['release_date']}',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                IconlyBold.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "${snapshot.data[0]['vote_average']}/10",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                child: Text(
                                  "(${snapshot.data[0]['vote_count']})",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 2,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${snapshot.data[0]['runtime']} minutes',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              if (snapshot.data[0]['adult'] == true)
                                Image(
                                  image: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/2217/2217624.png'),
                                  height: 25,
                                  width: 25,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          child: Text(
                            '${snapshot.data[0]['overview']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 15,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[350]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 15,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              '${snapshot.data[1]['overview']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 15,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[350],
                                  height: 1.1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 0.2,
                              width: 10,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'More Like This',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 0.1,
                              width: 295,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 1500,
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1 / 1.6,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data[2].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data[2][index]
                                            ['poster_path'] !=
                                        null){
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MoviesSeeMoreDetailsScreen(
                                                    movieId: snapshot.data[2][index]
                                                    ['id'],
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          clipBehavior:
                                          Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: Image(
                                            image: snapshot.data[2][index]
                                            ['poster_path'] ==
                                                null
                                                ? NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/512/3875/3875148.png')
                                                : NetworkImage(
                                              '${AppConstance.photosBaseUrl}${snapshot.data[2][index]['poster_path']}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }

                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
// AppConstance.photosBaseUrl}${snapshot.data[2][index]['poster_path']
// snapshot.data[2][index]['vote_average']
// MoreLikeThisDetailsScreen(
// movieId: snapshot.data[2][index]
// ['id'],
// ),
