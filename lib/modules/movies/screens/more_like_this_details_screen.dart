import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/app_provider.dart';
import '../../../core/constance/app_constance.dart';

class MoreLikeThisDetailsScreen extends StatelessWidget {
  final movieId;

  const MoreLikeThisDetailsScreen({Key key, this.movieId})
      : super(key: key);

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
                controller.getMoviesDetailsData(
                    movieId: movieId),
                controller.getMoviesArabicData(
                    movieId: movieId),
                controller.getMovieReviews(movieId: movieId),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 50,
                                left: 10,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
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
                          child: Container(
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
                                    child: Container(
                                      width: 35,
                                      child: Text(
                                        '${snapshot.data[0]['release_date']}',
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white),
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
                              Text(
                                "(${snapshot.data[0]['vote_count']})",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
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
                            maxLines: 15,
                            overflow: TextOverflow.ellipsis,
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
                              maxLines: 15,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[350],
                                  height: 1.1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data[0]['genres'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 15,
                                ),
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        '${snapshot.data[0]['genres'][index]['name']}',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              height: 0.2,
                              width: 10,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'Reviews',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              height: 0.2,
                              width: 334,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                        if(snapshot.data[2].length == 0 )
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 40,
                              ),
                              child: Text('No Reviews.',style: TextStyle(
                                color: Colors.white,
                              )),
                            ),
                          ),
                        if(snapshot.data[2].length > 0)
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data[2].length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:180,
                                                  child: Text(
                                                    '${snapshot.data[2][index]['author']}',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                SizedBox(
                                                  width:77,
                                                  child: Text(
                                                    '${snapshot.data[2][index]['created_at']}',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                if(snapshot.data[2][index]['author_details']['rating'] != null)
                                                  Container(
                                                    height: 20,
                                                    width: 65,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Colors.grey[800],
                                                    ),
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          IconlyBold.star,
                                                          color: Colors.amber,
                                                          size: 13,
                                                        ),
                                                        SizedBox(width: 2,),
                                                        Text(
                                                          '${snapshot.data[2][index]['author_details']['rating']}/10',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            SizedBox(
                                              width: 355,
                                              child: Text(
                                                '${snapshot.data[2][index]['content']}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey[350],
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
