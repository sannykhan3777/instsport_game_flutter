import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:instsport/screens/gameplay_screen.dart';
import 'package:instsport/screens/home_screen.dart';

class EndScreen extends StatefulWidget {
  final int scoree;

  EndScreen({Key key, this.scoree}) : super(key: key);

  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  AudioPlayer player;
  AudioCache audioCache;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  Color color1 = Colors.white;
  Color color2 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            "your_score".tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 115.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.scoree} ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "points".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 130.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => GamePlayScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                audioCache.play("touch.mp3");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => GamePlayScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Image.asset(
                                "assets/rectangle2.png",
                                width: 500,
                                height: 150,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                audioCache.play("touch.mp3");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => GamePlayScreen()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "play_again".tr(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Positioned(
                  top: 240,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              audioCache.play("touch.mp3");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(scoreee: widget.scoree)),
                                  (Route<dynamic> route) => false);
                            },
                            child: GestureDetector(
                              onTap: () {
                                audioCache.play("touch.mp3");
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(scoreee: widget.scoree)),
                                    (Route<dynamic> route) => false);
                              },
                              child: Image.asset(
                                "assets/rectangle3.png",
                                width: 500,
                                height: 150,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              audioCache.play("touch.mp3");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            scoreee: widget.scoree,
                                          )),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "main_menu".tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
              ],
            ),
          ),
          Positioned(
            child: Image.asset(
              "assets/vector.png",
              width: width,
            ),
          ),
          Positioned(
            bottom: 1.0,
            child: Image.asset(
              "assets/vector2.png",
              width: width,
              fit: BoxFit.fitWidth,
            ),
          ),
        ]),
      ),
    );
  }
}
