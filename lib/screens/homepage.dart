import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/models/newschannelsheadlinesmodel.dart';
import 'package:news_application/repositery/newsrepositery.dart';
import 'package:news_application/view%20model/newsviewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/category_icon.png",
              height: 30,
              width: 30,
            ),
          ),
          title: Text(
            'News Headlines',
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        body: ListView(
          children: [
            Container(
                height: height * .55,
                //color: Colors.purple,
                width: widht,
                child: FutureBuilder<NewsChannelsHeadlinesModel>(
                    future: newsViewModel.fetchNewsChannelHeadlinesApi(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: SpinKitChasingDots(
                          color: Color.fromARGB(255, 190, 44, 22),
                          size: 100,
                        ));
                      } else {
                        // return Container(
                        //   child: Text("api data has not shown"),
                        // );
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.4,
                                  // width: widht * .9,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: spinKit2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ));
                          });
                    }))
          ],
        )
        // body: FutureBuilder<List<dynamic>>(
        //   future: fetchData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     } else if (snapshot.hasError) {
        //       return Text('Error: ${snapshot.error}');
        //     } else {
        //       List? articles = snapshot.data;
        //       return ListView.builder(
        //         itemCount: articles?.length,
        //         itemBuilder: (context, index) {
        //           final article = articles?[index];
        //           return ListTile(
        //             title: Text(article['title']),
        //             subtitle: Text(article['description']),
        //             // trailing: Text(article),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
        );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.green,
  size: 50,
);
