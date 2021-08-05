import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/onboarding_screen.dart';
import 'package:flutter_practice/redux/models/models.dart';
import 'package:flutter_practice/redux/reducers/app_reducer.dart';
import 'package:flutter_practice/test_route.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';

void main() async {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      reduxSetup: false,
      testList: [],
    ),
  );
  print('Initial state: ${store.state}');

  runApp(StoreProvider(
    store: store,
    child: MyApp(),
  ));
}

// class TestData {
//   final List list;

//   TestData({@required this.list});

//   factory TestData.fromJson(Map<String, dynamic> json) {
//     return TestData(
//       list: json['list'],
//     );
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   Album({@required this.userId, @required this.id, @required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

class MyApp extends StatefulWidget {
  final List<String> entries = [];
  final List<int> colorCodes = [];

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController _controller;
  bool isLiked = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _save() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/apple.jpg";
    print(savePath);
    String fileUrl =
        "https://www.tompetty.com/sites/g/files/g2000007521/f/Sample-image10-highres.jpg";
    await Dio().download(fileUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
    await shareImage(savePath);
  }

  shareImage(String filePath) async {
    // await Share.share(filePath);
    await Share.shareFiles([filePath], text: 'Apples');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Practice",
      home: OnBoardingPage(),
      // Scaffold(
      //   appBar: AppBar(
      //     title: Text('Flutter Practice'),
      //   ),
      //   body: Center(
      //     child: GestureDetector(
      //       onTap: () async {
      //         setState(() {
      //           isLiked = !isLiked;
      //         });

      //         await _save();
      //         // shareImage();

      //         if (isLiked) {
      //           _controller.reset();
      //           _controller.forward();
      //         }

      //         if (!isLiked) {
      //           _controller.reverse();
      //         }
      //       },
      //       child: Lottie.network(
      //         'https://assets5.lottiefiles.com/packages/lf20_iw6Xr9.json',
      //         controller: _controller,
      //         onLoaded: (composition) {
      //           _controller..duration = composition.duration;
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

// Future futureAlbum;
// VideoPlayerController _controller;
// Future<void> _initializeVideoPlayerFuture;

// @override
// void initState() {
//   _controller = VideoPlayerController.network(
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//   );

//   _controller.setLooping(true);

//   _initializeVideoPlayerFuture = _controller.initialize();

//   // futureAlbum = fetchAlbum();
//   // print('Calling fetchDemoData()');
//   // fetchDemoData();
//   // print('Called fetchDemoData()');
//   super.initState();
// }

// @override
// void dispose() {
//   // Ensure disposing of the VideoPlayerController to free up resources.
//   _controller.dispose();

//   super.dispose();
// }

// void fetchDemoData(store) async {
//   // print('Inside fetchDemoData()');
//   final response = await http.get(
//     Uri.parse("https://run.mocky.io/v3/5af2e693-3480-4f24-8583-020189307d45"),
//   );
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     try {
//       print(TestData.fromJson(jsonDecode(response.body)));
//     } catch (e) {
//       print(e);
//     }
//     store.dispatch(
//       TestAction1(
//         TestData.fromJson(jsonDecode(response.body)).list,
//       ),
//     );
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// Future<TestData> fetchAlbum() async {
//   final response = await http.get(
//     Uri.parse("https://run.mocky.io/v3/5af2e693-3480-4f24-8583-020189307d45"),
//   );
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     try {
//       print(jsonDecode(response.body));
//     } catch (e) {
//       print(e);
//     }
//     return TestData.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// Column(
//           children: [
//             StoreConnector<AppState, List>(
//               onInit: (store) {
//                 fetchDemoData(store);
//               },
//               converter: (store) => store.state.testList,
//               builder: (context, List list) => Center(
//                 child: Text(
//                   list.toString(),
//                 ),
//               ),
//             ),
//             StoreConnector<AppState, bool>(
//               onInit: (store) {
//                 store.dispatch(
//                   TestAction(true),
//                 );
//               },
//               converter: (store) => store.state.reduxSetup,
//               builder: (context, bool reduxSetup) => Center(
//                 child: Text(
//                   reduxSetup.toString(),
//                 ),
//               ),
//             ),
//             Container(
//               height: 450,
//               width: 400,
//               child: BlurHash(hash: "L8Cr\$H%101IpM|WVbaj]01NH~As:"),
//             )
//           ],
//         ),

// FutureBuilder<TestData>(
//           future: futureAlbum,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Center(
//                   child: Text(
//                 snapshot.data.list.toString(),
//               ));
//             } else if (snapshot.hasError) {
//               return Center(child: Text("${snapshot.error}"));
//             }
//             // By default, show a loading spinner.
//             return Center(child: CircularProgressIndicator());
//           },
//         ),

// Stack(
//           children: [
//             // Use a FutureBuilder to display a loading spinner while waiting for the
//             // VideoPlayerController to finish initializing.
//             FutureBuilder(
//               future: _initializeVideoPlayerFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   // If the VideoPlayerController has finished initialization, use
//                   // the data it provides to limit the aspect ratio of the VideoPlayer.
//                   _controller.play();
//                   return VideoPlayer(_controller);
//                 } else {
//                   // If the VideoPlayerController is still initializing, show a
//                   // loading spinner.
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//             Container(
//               height: 240,
//               width: 240,
//               color: Colors.red,
//             ),
//           ],
//         ),

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TestRoute(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1, 0);
        var end = Offset(0, 0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          child: child,
          position: offsetAnimation,
        );
      });
}

// StoreConnector<AppState, bool>(
//           converter: (store) => store.state.reduxSetup,
//           builder: (context, bool reduxSetup) => Scaffold(
//               appBar: AppBar(title: Center(child: Text('Flutter Practice'))),
//               floatingActionButton: FloatingActionButton(onPressed: () {
//                 StoreProvider.of<AppState>(context)
//                     .dispatch(TestAction(!reduxSetup));
//               }),
//               body: SafeArea(
//                 child: SizedBox.expand(
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.yellow)),
//                         child: AnimatedSwitcher(
//                           duration: Duration(milliseconds: 124),
//                           transitionBuilder: (child, animation) {
//                             var begin = Offset(0, 1);
//                             var end = Offset(0, 0);
//                             var curve = Curves.ease;
//                             var tween = Tween(begin: begin, end: end)
//                                 .chain(CurveTween(curve: curve));
//                             var offsetAnimation = animation.drive(tween);
//                             return SlideTransition(
//                               child: child,
//                               position: offsetAnimation,
//                             );
//                           },
//                           child: reduxSetup
//                               ? Container(
//                                   height: 100.0,
//                                   width: 100.0,
//                                   color: Colors.red,
//                                 )
//                               : SizedBox(),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )),
//         ));
