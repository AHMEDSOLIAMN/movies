import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/movies_app_provider.dart';
import 'package:movies_application/controller/providers/tv_app_provider.dart';
import 'package:movies_application/modules/tv/screens/tv_season_episodes_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constance/app_constance.dart';
import '../../movies/screens/movies_search_delagate.dart';

class TvSeeMoreDetailsScreen extends StatelessWidget {
  final seriesId;

  const TvSeeMoreDetailsScreen({Key key, this.seriesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:
          SystemUiOverlayStyle(statusBarColor: Colors.black.withOpacity(0.2)),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Consumer<TvAppProvider>(
            builder: (context, controller, child) {
              return FutureBuilder(
                future: Future.wait([
                  controller.getSeriesDetailsDate(seriesId: seriesId),
                  controller.getSeriesArabicDetailsDate(seriesId: seriesId),
                  controller.geTvReviewsData(seriesId: seriesId),
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
                        mainAxisSize: MainAxisSize.min,
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
                                    Rect.fromLTRB(
                                        0, 0, rect.width, rect.height),
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
                                '${snapshot.data[0]['name']}',
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
                                          '${snapshot.data[0]['first_air_date']}',
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
                          TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  'Epsoides',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Reviews',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 1500,
                            child: TabBarView(
                              children: [
                                Column(
                                  children: [
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          snapshot.data[0]['seasons'].length,
                                      separatorBuilder: (context, index) =>
                                          Container(
                                        height: 0.1,
                                        width: double.infinity,
                                        color: Colors.yellow,
                                      ),
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SeasonEpisodesScreen(
                                                        seriesId:snapshot.data[0]['id'],
                                                        seasonNumber: snapshot
                                                                        .data[0]
                                                                    ['seasons']
                                                                [index]
                                                            ['season_number']),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              if (snapshot.data[0]['seasons']
                                                      [index]['poster_path'] !=
                                                  null)
                                                Row(
                                                  children: [
                                                    Card(
                                                      margin: EdgeInsets.zero,
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image(
                                                        image: NetworkImage(
                                                          '${AppConstance.photosBaseUrl}${snapshot.data[0]['seasons'][index]['poster_path']}',
                                                        ),
                                                        height: 100,
                                                        width: 80,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                '${snapshot.data[0]['seasons'][index]['name']}',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Episodes (${snapshot.data[0]['seasons'][index]['episode_count']})',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .yellow[
                                                                      100]),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 280,
                                                          child: Text(
                                                            '${snapshot.data[0]['seasons'][index]['overview']}',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                    ),
                                  ],
                                ),
                                if (snapshot.data[2].length == 0)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 100, left: 180),
                                    child: Text('No Reviews.',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                if (snapshot.data[2].length > 0)
                                  SizedBox(
                                    height: 700,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data[2].length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 10,
                                      ),
                                      itemBuilder: (context, index) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      'https://www.gravatar.com/avatar/87b1f10dd7dae245ac84657537983336.jpg'),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 120,
                                                          child: Text(
                                                            '${snapshot.data[2][index]['author']}',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 77,
                                                          child: Text(
                                                            '${snapshot.data[2][index]['created_at']}',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        if (snapshot.data[2]
                                                                        [index][
                                                                    'author_details']
                                                                ['rating'] !=
                                                            null)
                                                          Container(
                                                            height: 20,
                                                            width: 65,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  IconlyBold
                                                                      .star,
                                                                  color: Colors
                                                                      .amber,
                                                                  size: 13,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Text(
                                                                  '${snapshot.data[2][index]['author_details']['rating']}/10',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 355,
                                                      child: Text(
                                                        '${snapshot.data[2][index]['content']}',
                                                        maxLines: 10,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[350],
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
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
