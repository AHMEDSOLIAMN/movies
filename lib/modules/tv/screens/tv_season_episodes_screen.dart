import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/tv_app_provider.dart';
import 'package:movies_application/core/constance/app_constance.dart';
import 'package:provider/provider.dart';

class SeasonEpisodesScreen extends StatelessWidget {
  final seriesId;
  final seasonNumber;

  const SeasonEpisodesScreen({Key key, this.seriesId, this.seasonNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TvAppProvider>(
      builder: (context, controller, child) => Scaffold(
        body: FutureBuilder(
          future: Future.wait([
            controller.getSeasonsDetailsData(
              seasonNumber: seasonNumber,
              seriesId: seriesId,
            ),
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
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
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${snapshot.data[0]['poster_path']}',
                            ),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 35,
                            left: 7,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                IconlyBroken.arrow_left_2,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data[0]['name']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${snapshot.data[0]['overview']}',
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 0.3,
                                  width: 10,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Episodes',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 0.3,
                                  width: 304,
                                  color: Colors.yellow,
                                ),
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    // CircleAvatar(
                                    //   backgroundImage: NetworkImage(
                                    //     '${AppConstance.photosBaseUrl}${snapshot.data[0]['episodes'][index]['still_path']}',
                                    //   ),
                                    //   radius: 30,
                                    // ),
                                    Card(
                                      child: snapshot.data[0]['episodes']
                                                  [index]['still_path'] !=
                                              null
                                          ? Image(
                                              image: NetworkImage(
                                                '${AppConstance.photosBaseUrl}${snapshot.data[0]['episodes'][index]['still_path']}',
                                              ),
                                              height: 85,
                                              width: 65,
                                              fit: BoxFit.fill,
                                            )
                                          : Image(
                                              image: NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/128/4598/4598187.png',
                                              ),
                                              height: 85,
                                              width: 65,
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
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                '${snapshot.data[0]['episodes'][index]['name']}',
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
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
                                              "${snapshot.data[0]['episodes'][index]['vote_average']}/10",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              child: Text(
                                                "(${snapshot.data[0]['episodes'][index]['vote_count']})",
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${snapshot.data[0]['episodes'][index]['air_date']}',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 305,
                                          child: Text(
                                            '${snapshot.data[0]['episodes'][index]['overview']}',
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              itemCount: snapshot.data[0]['episodes'].length,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
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
          },
        ),
      ),
    );
  }
}
