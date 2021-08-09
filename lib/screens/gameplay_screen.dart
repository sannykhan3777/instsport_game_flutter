import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:instsport/screens/end_screen.dart';

class GamePlayScreen extends StatefulWidget {
  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  AudioPlayer player;
  AudioCache audioCache;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
    audioCache.play("background.mp3");
  }

  Color color1 = Colors.white;
  Color color2 = Colors.grey;

  List<ItemModel> items;
  List<ItemModel> items2;

  int score;
  bool gameOver;

  Timer _timer;
  int _start = 20;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            player.stop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EndScreen(
                  scoree: score,
                ),
              ),
            );
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initGame();
    startTimer();
    initPlayer();
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
          image: Image.asset("assets/ball.png"), name: "ball", value: "racket"),
      ItemModel(
          image: Image.asset("assets/football.png"),
          name: "football",
          value: "shoe"),
      ItemModel(
          image: Image.asset("assets/volley.png"),
          name: "volleyball",
          value: "hand"),
      ItemModel(
          image: Image.asset("assets/basketball.png"),
          name: "basketball",
          value: "glove"),
      ItemModel(
          image: Image.asset("assets/whiteball.png"),
          name: "whiteball",
          value: "stick"),
      ItemModel(
          image: Image.asset("assets/baseball.png"),
          name: "baseball",
          value: "basebat"),
    ];

    items2 = [
      ItemModel(
          image: Image.asset("assets/racket.png"),
          name: "ball",
          value: "racket"),
      ItemModel(
          image: Image.asset("assets/shoes.png"),
          name: "football",
          value: "shoe"),
      ItemModel(
          image: Image.asset("assets/hand.png"),
          name: "volleyball",
          value: "hand"),
      ItemModel(
          image: Image.asset("assets/glove.png"),
          name: "basketball",
          value: "glove"),
      ItemModel(
          image: Image.asset("assets/stick.png"),
          name: "whiteball",
          value: "stick"),
      ItemModel(
          image: Image.asset("assets/basebat.png"),
          name: "baseball",
          value: "basebat"),
    ];
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (items.length == 0) {
      gameOver = true;
      setState(() {
        _start = 0;
      });
    }

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
                  top: 45.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        color: Color(0xFFE8B82F),
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "00:$_start",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 24.0,
                            color: Colors.white,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
                if (!gameOver)
                  Positioned(
                    top: 80.0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: items.map((item) {
                          return Draggable<ItemModel>(
                            data: item,
                            childWhenDragging: item.image,
                            feedback: Container(
                              child: item.image,
                              width: 80.0,
                              height: 80.0,
                              color: Color(0xFFECD823).withOpacity(0.3),
                            ),
                            child: item.image,
                          );
                        }).toList()),
                  ),
                Positioned(
                  top: 225.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items2.map((item) {
                      return DragTarget<ItemModel>(
                        onAccept: (receivedItem) {
                          if (item.value == receivedItem.value) {
                            setState(() {
                              items.remove(receivedItem);
                              items2.remove(item);
                              score += 10;
                              _start += 2;
                              item.accepting = false;
                            });
                          } else {
                            setState(() {
                              score -= 5;
                              _start -= 2;
                              item.accepting = false;
                            });
                          }
                        },
                        onLeave: (receivedItem) {
                          setState(() {
                            item.accepting = false;
                          });
                        },
                        onWillAccept: (receivedItem) {
                          setState(() {
                            item.accepting = true;
                          });
                          return true;
                        },
                        builder: (context, acceptedItems, rejectedItem) =>
                            Container(
                          color: item.accepting
                              ? Color(0xFF9B9E0C).withOpacity(0.1)
                              : Colors.red.withOpacity(0.0),
                          child: item.image,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  top: 320.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "score:".tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "$score",
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 23.0,
                        ),
                      ),
                      Text(
                        "points".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 23.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
            top: 0.0,
            left: 10.0,
            child: GestureDetector(
              onTap: () {
                player.stop();
                audioCache.play("touch.mp3");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EndScreen(
                      scoree: score,
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/rectangle.png",
                    width: 140,
                    height: 130,
                  ),
                  Align(
                    child: Icon(
                      Icons.arrow_back,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
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

class ItemModel {
  final String name;
  final String value;
  final Image image;
  final IconData icon;
  bool accepting;

  ItemModel(
      {this.name, this.value, this.image, this.icon, this.accepting = false});
}
