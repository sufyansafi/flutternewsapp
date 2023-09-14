import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application/models/newschannelsheadlinesmodel.dart';
import 'package:news_application/repositery/newsrepositery.dart';
import 'package:news_application/view%20model/newsviewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

enum FilterList { CNN, ARY, ALJAZERA, BBCNEWS }

class _HomePageState extends State<HomePage> {
  FilterList? selectedMenu;
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");

  // List<PopupMenuItem<String>> _menuItems = [
  //   PopupMenuItem<String>(
  //     value: 'option1',
  //     child: Text('bbc News'),
  //   ),
  //   PopupMenuItem<String>(
  //     value: 'option2',
  //     child: Text('Ary News'),
  //   ),
  //   PopupMenuItem<String>(
  //     value: 'option3',
  //     child: Text('geographical channel'),
  //   ),
  // ];

  // String selectedMenuItem = 'None';

  // void _handleMenuItemSelected(String value) {
  //   setState(() {
  //     selectedMenuItem = value;
  //   });

  //   // Handle the selected item with if-else statements
  //   if (value == 'option1') {
  //     // Handle Option 1
  //     // Add your code here for Option 1
  //   } else if (value == 'option2') {
  //     // Handle Option 2
  //     // Add your code here for Option 2
  //   } else if (value == 'option3') {
  //     // Handle Option 3
  //     // Add your code here for Option 3
  //   }
  // }

  String name = "abc-news";
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
              color: Color.fromARGB(136, 13, 227, 235),
            ),
          ),
          title: Center(
            child: Text(
              'News',
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(136, 13, 227, 235),
              ),
            ),
          ),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedMenu,
                onSelected: (FilterList item) {
                  if (FilterList.BBCNEWS.name == item.name) {
                    name = "bbc-news";
                  }
                  if (FilterList.CNN.name == item.name) {
                    name = "cnn";
                  }
                  if (FilterList.ARY.name == item.name) {
                    name = "bbc-news";

                    setState(() {
                      selectedMenu = item;
                    });
                  }
                 // newsViewModel.fetchNewsChannelHeadlinesApi();
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      PopupMenuItem(
                          value: FilterList.CNN, child: Text("  cnn news")),
                      PopupMenuItem(
                          value: FilterList.BBCNEWS, child: Text("bbc news ")),
                      PopupMenuItem(
                          value: FilterList.ARY, child: Text("ary news")),
                    ])
          ],
        ),

        // actions: <Widget>[
        //   PopupMenuButton<String>(
        //     initialValue: "bbc news",
        //     // Create a list of PopupMenuItems
        //     itemBuilder: (BuildContext context) {
        //       return [
        //         PopupMenuItem<String>(
        //           value: 'option1',
        //           child: Text('bbc news'),
        //         ),
        //         PopupMenuItem<String>(
        //           value: 'option2',
        //           child: Text('geographical news'),
        //         ),
        //         PopupMenuItem<String>(
        //           value: 'option3',
        //           child: Text('ary news'),
        //         ),
        //       ];
        //     },
        //     // Handle the item selection
        //     onSelected: (String value) {
        //       // You can perform actions based on the selected item here
        //       switch (value) {
        //         case 'option1':
        //           // Handle Option 1 selection
        //           break;
        //         case 'option2':
        //           // Handle Option 2 selection
        //           break;
        //         case 'option3':
        //           // Handle Option 3 selection
        //           break;
        //       }
        //     },
        //   ),
        // ]

        body: ListView(
          children: [
            Container(
                height: height * .44,
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
                            DateTime datetime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Container(
                                child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.4,
                                  // width: widht * 0.4,
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
                                ),
                                Positioned(
                                  bottom: 16,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height: height * .23,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: widht * 0.5,
                                              child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.anton(
                                                      letterSpacing: 0,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.grey)),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: widht * 0.5,
                                              child: SingleChildScrollView(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.anton(
                                                                letterSpacing:
                                                                    0,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .grey)),
                                                    Text(
                                                        format.format(datetime),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.anton(
                                                                letterSpacing:
                                                                    0,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .grey)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
