import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/tv_app_provider.dart';
import 'package:movies_application/modules/tv/screens/tv_see_more_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constance/app_constance.dart';

class TvPopularScreen extends StatelessWidget {
  const TvPopularScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:
          SystemUiOverlayStyle(statusBarColor: Colors.black.withOpacity(0.2)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.1),
          elevation: 5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(IconlyBroken.arrow_left_2),
          ),
          title: Text(
            'Popular Series',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<TvAppProvider>(
          builder: (context, controller, child) {
            return FutureBuilder(
              future: Future.wait([
                controller.getTvPopularData(),
              ]),
              builder: (context, snapshot) {
                List data = snapshot.data;
                if (snapshot.hasError) {
                  Center(
                    child: Text(
                      'NetWork Error',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data[0].length,
                          itemBuilder: (context, index) => SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Card(
                                    color: Colors.grey[850],
                                    elevation: 5,
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TvSeeMoreDetailsScreen(
                                                    seriesId: data[0][index]
                                                        ['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Card(
                                                  elevation: 7,
                                                  margin: EdgeInsets.zero,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Image(
                                                    image: NetworkImage(
                                                      '${AppConstance.photosBaseUrl}${data[0][index]['poster_path']}',
                                                    ),
                                                    height: 140,
                                                    width: 110,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 255,
                                                      child: Text(
                                                        '${data[0][index]['name']}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 40,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .red.shade400,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: SizedBox(
                                                                width: 35,
                                                                child: Text(
                                                                  '${data[0][index]['first_air_date']}',
                                                                  maxLines: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
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
                                                          "${data[0][index]['vote_average']}/10",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Text(
                                                            "(${data[0][index]['vote_count']})",
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
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 255,
                                                      child: Text(
                                                        '${data[0][index]['overview']}',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey[300]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
