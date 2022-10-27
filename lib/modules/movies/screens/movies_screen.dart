import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/app_provider.dart';
import 'package:movies_application/core/constance/app_constance.dart';
import 'package:movies_application/modules/movies/screens/movies_details_screen.dart';
import 'package:movies_application/modules/movies/screens/popular_movies_screen.dart';
import 'package:movies_application/modules/movies/screens/search_delagate.dart';
import 'package:movies_application/modules/movies/screens/top_rated_movies_screen.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle(statusBarColor: Colors.black.withOpacity(0.2)),
      child: Consumer<AppProvider>(
        builder: (context, controller, child) => Scaffold(
          extendBodyBehindAppBar: true,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            child: Icon(Icons.search),
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: Future.wait([
                controller.getNowPlayingData(),
                controller.getPopularMoviesData(),
                controller.getTopRatedData(),
              ]),
              builder: (context, snapshot) {
                List data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 350,
                      ),
                      child: Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 350.0,
                          autoPlay: true,
                        ),
                        items: [1, 2, 3, 4, 5, 6, 7, 9, 10].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (rect) {
                                        return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            // fromLTRB
                                            Colors.black,
                                            Colors.transparent,
                                          ],
                                          stops: [0.1, 0.99],
                                        ).createShader(
                                          Rect.fromLTRB(
                                              0, 0, rect.width, rect.height),
                                        );
                                      },
                                      blendMode: BlendMode.dstIn,
                                      child: Image(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${data[0][i]['poster_path']}',
                                        ),
                                        height: 350,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 250.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 5,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Now Playing',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Text(
                                          //   '${data[0][i]['title']}',
                                          //   style: TextStyle(
                                          //     color: Colors.white,
                                          //     fontSize: 18,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            Text(
                              'Popular',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PopularMoviesScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See More',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 180,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: EdgeInsets.zero,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 10,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MoviesDetailsScreen(
                                              movieId: data[1][index]['id'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image(
                                        image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500${data[1][index]['poster_path']}",
                                        ),
                                        height: 180,
                                        width: 130,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          IconlyBold.star,
                                          color: Colors.amber,
                                          size: 35,
                                        ),
                                        Text(
                                          '${data[1][index]['vote_average']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 0.1,
                        width: double.infinity,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            Text(
                              'Top Rated',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TopRatedMoviesScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'See More',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 180,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 10,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MoviesDetailsScreen(
                                            movieId: data[2][index]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image(
                                      image: NetworkImage(
                                        '${AppConstance.photosBaseUrl}${data[2][index]['poster_path']}',
                                      ),
                                      height: 180,
                                      width: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        IconlyBold.star,
                                        color: Colors.amber,
                                        size: 35,
                                      ),
                                      Text(
                                        '${data[2][index]['vote_average']}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: 15,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Network Error',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
